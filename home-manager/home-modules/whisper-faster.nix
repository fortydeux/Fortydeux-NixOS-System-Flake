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
  ]);

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
  # dictate-fw-ptt-start
  dictate-fw-ptt-start = pkgs.writeShellScriptBin "dictate-fw-ptt-start" ''
    set -euo pipefail
    TMP="/tmp/dictate-ptt.wav"
    PIDFILE="/tmp/dictate-ptt.pid"
    LOGFILE="/tmp/dictate-debug.log"

    {
      echo "[DEBUG] dictate-fw-ptt-start: Starting at $(date)..."
      echo "[DEBUG] Environment: PWD=$PWD, USER=$USER, PULSE_SERVER=''${PULSE_SERVER:-unset}"
      echo "[DEBUG] XDG vars: XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-unset}, WAYLAND_DISPLAY=''${WAYLAND_DISPLAY:-unset}"
      echo "[DEBUG] PATH=$PATH"
    } >> "$LOGFILE" 2>&1

    {
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "[DEBUG] Stopping existing recording process $(cat "$PIDFILE")"
        kill -TERM "$(cat "$PIDFILE")" || true
        sleep 0.5  # Give it time to exit gracefully
        rm -f "$PIDFILE"
      fi
      
      # Only remove temp file if we're starting a new recording
      rm -f "$TMP"

      # Check available audio sources first
      echo "[DEBUG] Available pulse sources:"
      ${pkgs.pulseaudio}/bin/pactl list short sources || echo "[DEBUG] pactl failed"
      
      # Check current volume/mute status
      echo "[DEBUG] Default source info:"
      DEFAULT_SOURCE=$(${pkgs.pulseaudio}/bin/pactl get-default-source 2>/dev/null || echo "")
      if [ -n "$DEFAULT_SOURCE" ]; then
        ${pkgs.pulseaudio}/bin/pactl list sources | grep -A 20 "Name: $DEFAULT_SOURCE" | grep -E "(Mute|Volume)" || true
      fi
      
      # Ensure proper environment for audio
      export PULSE_RUNTIME_PATH="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/pulse"
      export PULSE_UNIX_SOCKET="$PULSE_RUNTIME_PATH/native"
      
      # Record from PipeWire via Pulse, 16 kHz mono WAV
      echo "[DEBUG] Starting ffmpeg recording..."
      ${pkgs.ffmpeg}/bin/ffmpeg -nostdin -hide_banner -loglevel info \
        -f pulse -i default -ac 1 -ar 16000 -y "$TMP" &
      PID=$!
      echo $PID > "$PIDFILE"
      echo "[DEBUG] Recording started with PID $PID"
    } >> "$LOGFILE" 2>&1
  '';

  # dictate-fw-ptt-stop
  dictate-fw-ptt-stop = pkgs.writeShellScriptBin "dictate-fw-ptt-stop" ''
    set -euo pipefail
    TMP="/tmp/dictate-ptt.wav"
    PIDFILE="/tmp/dictate-ptt.pid"
    LOGFILE="/tmp/dictate-debug.log"

    {
      echo "[DEBUG] dictate-fw-ptt-stop: Starting at $(date)..."
      echo "[DEBUG] Environment: PWD=$PWD, USER=$USER, PULSE_SERVER=''${PULSE_SERVER:-unset}"
      echo "[DEBUG] XDG vars: XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-unset}, WAYLAND_DISPLAY=''${WAYLAND_DISPLAY:-unset}"
    } >> "$LOGFILE" 2>&1

    {
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        PID="$(cat "$PIDFILE")"
        echo "[DEBUG] Stopping recording process $PID"
        kill -TERM "$PID" || true   # SIGTERM for cleaner shutdown
        
        # Wait for process to actually exit (give much more time)
        for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
          if kill -0 "$PID" 2>/dev/null; then
            echo "[DEBUG] Waiting for ffmpeg to exit... (attempt $j)"
            sleep 0.5
          else
            echo "[DEBUG] ffmpeg process exited"
            break
          fi
        done
        
        # Force kill if still running after 10 seconds
        if kill -0 "$PID" 2>/dev/null; then
          echo "[DEBUG] Force killing ffmpeg process after timeout"
          kill -KILL "$PID" || true
          sleep 0.5
        fi
        
        rm -f "$PIDFILE"
      else
        echo "[DEBUG] No active recording found"
      fi

      # Wait longer for ffmpeg to finish writing the file
      sleep 1.0
      
      # Check if file exists and has content
      echo "[DEBUG] Checking for audio file..."
      ls -la "$TMP" 2>/dev/null || echo "[DEBUG] File does not exist"
      
      # Wait up to 3 seconds for file to be ready
      for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
        if [ -s "$TMP" ]; then
          SIZE=$(wc -c < "$TMP")
          echo "[DEBUG] Audio file ready after $((i*200))ms, size=$SIZE bytes"
          break
        fi
        echo "[DEBUG] Waiting for audio file... (attempt $i)"
        ls -la "$TMP" 2>/dev/null || echo "[DEBUG] File still missing"
        sleep 0.2
      done
      
      if [ ! -s "$TMP" ]; then
        echo "[DEBUG] No audio file or empty audio file, exiting"
        exit 0
      fi
      
      echo "[DEBUG] Calling transcription..."
      TEXT="$(${lib.getExe fw-transcribe} "$TMP" 2>>"$LOGFILE")"
      TRANSCRIBE_EXIT=$?
      
      echo "[DEBUG] Transcription exit code: $TRANSCRIBE_EXIT"
      echo "[DEBUG] Raw transcription output: '$TEXT'"
      
      if [ $TRANSCRIBE_EXIT -eq 0 ] && [ -n "$TEXT" ]; then
        echo "[DEBUG] Typing text: '$TEXT'"
        ${pkgs.wtype}/bin/wtype -- "$TEXT" >/dev/null 2>&1
      else
        echo "[DEBUG] No text to type (exit=$TRANSCRIBE_EXIT, text='$TEXT')"
      fi
    } >> "$LOGFILE" 2>&1
  '';

in
{
  options.services.dictation-faster = {
    enable = lib.mkEnableOption "Local push-to-talk dictation via Faster-Whisper";
    model = lib.mkOption {
      type = lib.types.str;
      default = "medium";
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
      ffmpeg
      sox     # optional, for trimming if you want
      pyEnv
      fw-transcribe
      dictate-fw-ptt-start
      dictate-fw-ptt-stop
    ];
  };
}
