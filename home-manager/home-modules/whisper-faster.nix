{ config, lib, pkgs, ... }:
let
  # Python env with faster-whisper + deps
  py = pkgs.python313.override {
    packageOverrides = self: super: {
      coloredlogs = super.coloredlogs.overridePythonAttrs (old: {
        doCheck = false;  # disable upstream tests that fail in sandbox
      });
    };
  };
  pyEnv = pkgs.python313.withPackages (ps: with ps; [
    faster-whisper
    soundfile        # for reading wavs if needed
    numpy
    sounddevice     # for real-time audio capture
  ]);
  
  # Daemon script
  faster-whisper-daemon = pkgs.writeShellScriptBin "faster-whisper-daemon" ''
    export WHISPER_MODEL="${config.services.dictation-faster.model}"
    export WHISPER_LANGUAGE="${config.services.dictation-faster.language}"
    export WHISPER_DEVICE="${config.services.dictation-faster.device}"
    exec ${pyEnv}/bin/python - << 'DAEMON_PY'
#!/usr/bin/env python3
"""
Real-time whisper transcription daemon.
Keeps model loaded and processes audio via Unix socket communication.
"""

import asyncio
import json
import os
import socket
import sys
import tempfile
import threading
import time
from pathlib import Path
import numpy as np
import sounddevice as sd
import soundfile as sf
from faster_whisper import WhisperModel

class WhisperDaemon:
    def __init__(self, model_size="tiny", language="en", device="cpu"):
        self.model_size = model_size
        self.language = language
        self.device = device
        self.model = None
        self.socket_path = "/tmp/faster-whisper-daemon.sock"
        self.recording = False
        self.audio_buffer = []
        self.sample_rate = 16000
        self.min_audio_length = 0.5  # Minimum 0.5s before transcription
        
        # Logging setup
        self.log_file = open("/tmp/faster-whisper-daemon.log", "a")
        
    def log(self, message):
        timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] {message}", file=self.log_file, flush=True)
        
    async def load_model(self):
        """Load the Whisper model once at startup."""
        self.log(f"Loading Whisper model: {self.model_size}, device: {self.device}")
        try:
            compute_type = "int8" if self.device == "cpu" else "float16"
            self.model = WhisperModel(self.model_size, device=self.device, compute_type=compute_type)
            self.log("Model loaded successfully")
        except Exception as e:
            self.log(f"Failed to load model: {e}")
            sys.exit(1)
            
    def start_recording(self):
        """Start audio recording in background thread."""
        if self.recording:
            self.log("Already recording, ignoring start command")
            return
            
        self.log("Starting audio recording")
        self.recording = True
        self.audio_buffer = []
        
        def record_callback(indata, frames, time, status):
            if status:
                self.log(f"Audio callback status: {status}")
            if self.recording:
                self.audio_buffer.append(indata.copy())
                
        try:
            self.stream = sd.InputStream(
                samplerate=self.sample_rate,
                channels=1,
                dtype=np.float32,
                callback=record_callback,
                blocksize=512,   # Smaller blocks for lower latency
                device=None  # Use default input device
            )
            self.stream.start()
            self.log("Audio stream started")
        except Exception as e:
            self.log(f"Failed to start recording: {e}")
            self.recording = False
            
    def stop_recording_and_transcribe(self):
        """Stop recording and transcribe the audio buffer."""
        if not self.recording:
            self.log("Not recording, ignoring stop command")
            return ""
            
        self.log("Stopping recording and transcribing")
        self.recording = False
        
        try:
            self.stream.stop()
            self.stream.close()
        except Exception as e:
            self.log(f"Error stopping stream: {e}")
            
        if not self.audio_buffer:
            self.log("No audio data recorded")
            return ""
            
        # Concatenate audio buffer
        audio_data = np.concatenate(self.audio_buffer, axis=0)
        duration = len(audio_data) / self.sample_rate
        self.log(f"Recorded {len(audio_data)} samples ({duration:.2f}s)")
        
        # Skip transcription if too short
        if duration < self.min_audio_length:
            self.log(f"Audio too short ({duration:.2f}s), skipping transcription")
            return ""
        
        # Save to temporary file for Whisper (it expects file input)
        with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp_file:
            sf.write(tmp_file.name, audio_data, self.sample_rate)
            
            try:
                # Transcribe
                self.log("Starting transcription")
                segments, info = self.model.transcribe(
                    tmp_file.name,
                    language=self.language,
                    vad_filter=False,  # Skip VAD for speed
                    beam_size=1,
                    temperature=0.0,   # Deterministic output
                    condition_on_previous_text=False  # Don't use context
                )
                
                result = " ".join(s.text.strip() for s in segments).strip()
                self.log(f"Transcription result: '{result}'")
                return result
                
            except Exception as e:
                self.log(f"Transcription failed: {e}")
                return ""
            finally:
                # Clean up temp file
                try:
                    os.unlink(tmp_file.name)
                except:
                    pass
                    
    async def handle_client(self, reader, writer):
        """Handle client connections via Unix socket."""
        try:
            data = await reader.read(1024)
            command = data.decode().strip()
            self.log(f"Received command: {command}")
            
            if command == "start":
                self.start_recording()
                response = "ok"
            elif command == "stop":
                result = self.stop_recording_and_transcribe()
                response = result if result else "no_result"
            elif command == "status":
                response = "recording" if self.recording else "idle"
            elif command == "shutdown":
                self.log("Shutdown requested")
                response = "ok"
                writer.write(response.encode())
                await writer.drain()
                writer.close()
                await writer.wait_closed()
                sys.exit(0)
            else:
                response = "unknown_command"
                
            self.log(f"Sending response: {response[:50]}...")
            writer.write(response.encode() + b'\n')
            await writer.drain()
            await asyncio.sleep(0.1)  # Give time for data to send
            
        except Exception as e:
            self.log(f"Error handling client: {e}")
        finally:
            try:
                await asyncio.sleep(0.1)
                writer.close()
                await writer.wait_closed()
            except Exception as e:
                self.log(f"Error closing connection: {e}")
            
    async def run_server(self):
        """Run the Unix socket server."""
        # Remove existing socket
        try:
            os.unlink(self.socket_path)
        except FileNotFoundError:
            pass
            
        server = await asyncio.start_unix_server(
            self.handle_client,
            path=self.socket_path
        )
        
        self.log(f"Daemon listening on {self.socket_path}")
        
        async with server:
            await server.serve_forever()
            
    async def run(self):
        """Main daemon loop."""
        self.log("Whisper daemon starting")
        await self.load_model()
        await self.run_server()

def main():
    # Get config from environment or defaults
    model_size = os.environ.get("WHISPER_MODEL", "tiny")
    language = os.environ.get("WHISPER_LANGUAGE", "en") 
    device = os.environ.get("WHISPER_DEVICE", "cpu")
    
    daemon = WhisperDaemon(model_size, language, device)
    
    try:
        asyncio.run(daemon.run())
    except KeyboardInterrupt:
        daemon.log("Daemon shutdown requested")
    except Exception as e:
        daemon.log(f"Daemon crashed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
DAEMON_PY
  '';

  fw-transcribe = pkgs.writeShellScriptBin "fw-transcribe" ''
    set -euo pipefail
    IN="$1"
    MODEL="${config.services.dictation-faster.model}"
    LANG="${config.services.dictation-faster.language}"
    DEV="${config.services.dictation-faster.device}"
    
    echo "[DEBUG] fw-transcribe: input=$IN, model=$MODEL, lang=$LANG, device=$DEV" >&2
    [ -f "$IN" ] && echo "[DEBUG] Audio file exists, size=$(wc -c < "$IN") bytes" >&2 || echo "[DEBUG] Audio file missing!" >&2
    
    ${pyEnv}/bin/python - << 'PY' "$IN" "$MODEL" "$LANG" "$DEV"
import sys
import os
from faster_whisper import WhisperModel

audio_path, model_size, lang, device = sys.argv[1:5]
print(f"[DEBUG] Python: audio_path={audio_path}, model_size={model_size}, lang={lang}, device={device}", file=sys.stderr)
print(f"[DEBUG] Audio file exists: {os.path.exists(audio_path)}, size: {os.path.getsize(audio_path) if os.path.exists(audio_path) else 'N/A'} bytes", file=sys.stderr)

try:
    model = WhisperModel(model_size, device=device, compute_type="int8" if device=="cpu" else "float16")
    print("[DEBUG] Model loaded successfully", file=sys.stderr)
    
    segments, info = model.transcribe(
        audio_path, language=lang, vad_filter=True,
        vad_parameters={"min_silence_duration_ms": 200}, beam_size=5
    )
    print(f"[DEBUG] Transcription started, detected language: {info.language}", file=sys.stderr)
    
    result = " ".join(s.text.strip() for s in segments).strip()
    print(f"[DEBUG] Transcription result: '{result}'", file=sys.stderr)
    print(result)
except Exception as e:
    print(f"[ERROR] Transcription failed: {e}", file=sys.stderr)
    sys.exit(1)
PY
  '';
  # New daemon-based scripts
  dictate-fw-ptt-start = pkgs.writeShellScriptBin "dictate-fw-ptt-start" ''
    SOCKET="/tmp/faster-whisper-daemon.sock"
    LOGFILE="/tmp/faster-whisper-daemon.log"
    
    # Check if daemon is running
    if [ ! -S "$SOCKET" ]; then
      echo "Starting faster-whisper daemon..." >&2
      ${faster-whisper-daemon}/bin/faster-whisper-daemon &
      # Wait for socket to appear
      for i in 1 2 3 4 5 6 7 8 9 10; do
        [ -S "$SOCKET" ] && break
        sleep 0.5
      done
      if [ ! -S "$SOCKET" ]; then
        echo "Failed to start daemon" >&2
        exit 1
      fi
    fi
    
    # Send start command
    echo "start" | ${pkgs.socat}/bin/socat - UNIX-CONNECT:"$SOCKET" >/dev/null 2>&1
  '';

  dictate-fw-ptt-stop = pkgs.writeShellScriptBin "dictate-fw-ptt-stop" ''
    SOCKET="/tmp/faster-whisper-daemon.sock"
    
    # Check if daemon is running
    if [ ! -S "$SOCKET" ]; then
      echo "Faster-whisper daemon not running" >&2
      exit 1
    fi
    
    # Send stop command and get transcription result (with longer timeout)
    TEXT="$(echo "stop" | ${pkgs.socat}/bin/socat -T 30 -t 30 - UNIX-CONNECT:"$SOCKET" | head -1)"
    
    # Type the result if not empty
    if [ -n "$TEXT" ] && [ "$TEXT" != "ok" ] && [ "$TEXT" != "no_result" ]; then
      ${pkgs.wtype}/bin/wtype -- "$TEXT"
    fi
  '';
  
  # Daemon management scripts
  faster-whisper-daemon-start = pkgs.writeShellScriptBin "faster-whisper-daemon-start" ''
    SOCKET="/tmp/faster-whisper-daemon.sock"
    if [ -S "$SOCKET" ]; then
      echo "Daemon already running"
      exit 0
    fi
    echo "Starting faster-whisper daemon..."
    ${faster-whisper-daemon}/bin/faster-whisper-daemon &
  '';
  
  faster-whisper-daemon-stop = pkgs.writeShellScriptBin "faster-whisper-daemon-stop" ''
    SOCKET="/tmp/faster-whisper-daemon.sock"
    if [ -S "$SOCKET" ]; then
      echo "shutdown" | ${pkgs.socat}/bin/socat - UNIX-CONNECT:"$SOCKET" >/dev/null 2>&1
      sleep 1
      rm -f "$SOCKET"
    fi
    pkill -f faster-whisper-daemon || true
  '';

in
{
  options.services.dictation-faster = {
    enable = lib.mkEnableOption "Local push-to-talk dictation via Faster-Whisper";
    model = lib.mkOption {
      type = lib.types.str;
      default = "tiny";
      example = "small.en";
      description = "Whisper model size (tiny|base|small|medium|large-v3 or matching .ct2 conversion).";
    };
    language = lib.mkOption {
      type = lib.types.str;
      default = "en";
      description = "Language code for transcription.";
    };
    device = lib.mkOption {
      type = lib.types.str;
      default = "cpu"; # or "cuda"
      description = "CTranslate2 device (cpu or cuda).";
    };
  };

  config = lib.mkIf config.services.dictation-faster.enable {
    home.packages = with pkgs; [
      wtype
      socat   # for Unix socket communication
      pyEnv
      faster-whisper-daemon
      faster-whisper-daemon-start
      faster-whisper-daemon-stop
      dictate-fw-ptt-start
      dictate-fw-ptt-stop
      # Legacy tools (keep for fallback)
      ffmpeg
      fw-transcribe
    ];
  };
}
