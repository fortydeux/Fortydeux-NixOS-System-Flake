{ config, lib, pkgs, ... }:
let
  whisperPkg = pkgs.openai-whisper-cpp;

  # CLI wrapper that prints plain text to stdout
  wcpp-transcribe = pkgs.writeShellScriptBin "wcpp-transcribe" ''
    set -euo pipefail
    IN="$1"
    MODEL="${config.services.dictation-whispercpp.modelPath}"
    LANG="${config.services.dictation-whispercpp.language}"

    # Run whisper.cpp CLI and write a .txt sidecar in /tmp
    "${lib.getExe whisperPkg}" \
      -m "$MODEL" \
      -f "$IN" \
      -l "$LANG" \
      -otxt \
      -of /tmp/wcpp-out >/dev/null

    # Emit transcript to stdout
    cat /tmp/wcpp-out.txt | tr -d '\r'
  '';
  # dictate-wc-ptt-start
  dictate-wc-ptt-start = pkgs.writeShellScriptBin "dictate-wc-ptt-start" ''
    set -euo pipefail
    TMP="/tmp/dictate-ptt.wav"
    PIDFILE="/tmp/dictate-ptt.pid"

    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      kill -TERM "$(cat "$PIDFILE")" || true
      rm -f "$PIDFILE"
    fi
    rm -f "$TMP"

    ${pkgs.ffmpeg}/bin/ffmpeg -nostdin -hide_banner -loglevel error \
      -f pulse -i default -ac 1 -ar 16000 -y "$TMP" &
    echo $! > "$PIDFILE"
  '';

  # dictate-wc-ptt-stop
  dictate-wc-ptt-stop = pkgs.writeShellScriptBin "dictate-wc-ptt-stop" ''
    set -euo pipefail
    TMP="/tmp/dictate-ptt.wav"
    PIDFILE="/tmp/dictate-ptt.pid"

    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      kill -INT "$(cat "$PIDFILE")" || true
      rm -f "$PIDFILE"
    fi

    sleep 0.05
    [ -s "$TMP" ] || exit 0
    TEXT="$(${lib.getExe wcpp-transcribe} "$TMP")"
    [ -n "$TEXT" ] && ${pkgs.wtype}/bin/wtype -- "$TEXT"
  '';

in
{
  options.services.dictation-whispercpp = {
    enable = lib.mkEnableOption "Local push-to-talk dictation via whisper.cpp";
    modelPath = lib.mkOption {
      type = lib.types.str;
      # nixpkgs installs sample models; this is a sensible default on most channels.
      default = "${whisperPkg}/share/whisper/models/ggml-small.en.bin";
      example = "/home/you/models/ggml-medium.bin";
      description = "Path to ggml/gguf Whisper model for whisper.cpp";
    };
    language = lib.mkOption {
      type = lib.types.str;
      default = "en";
      description = "Language code for transcription.";
    };
  };

  config = lib.mkIf config.services.dictation-whispercpp.enable {
    home.packages = with pkgs; [
      wtype
      ffmpeg
      sox
      whisperPkg
      wcpp-transcribe
      dictate-wc-ptt-start
      dictate-wc-ptt-stop
    ];
  };
}
