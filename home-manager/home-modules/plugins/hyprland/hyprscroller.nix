{
  lib,
  fetchFromGitHub,
  cmake,
  hyprland,
  hyprlandPlugins,
}:
hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprscroller";
  version = "0.48.1";

  src = fetchFromGitHub {
    owner = "dawsers";
    repo = "hyprscroller";
    rev = "b14552a";
    hash = "sha256-e3AFZnfTqaqExi9eBGTcTDV7IghJ9fisJPKxgPG+h0g=";
  };

  # any nativeBuildInputs required for the plugin
  nativeBuildInputs = [cmake];

  # set any buildInputs that are not already included in Hyprland
  # by default, Hyprland and its dependencies are included
  buildInputs = [];

  installPhase = ''
    runHook preInstall
    install -Dm755 hyprscroller.so $out/lib/hyprland/plugins/hyprscroller.so
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/dawsers/hyprscroller";
    description = "Hyprland layout plugin providing a scrolling layout like PaperWM";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
