{
  lib,
  hyprland,
  hyprlandPlugins,
  cmake,
  fetchFromGitHub,
  unstableGitUpdater,
}:

hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprscroller";
  version = "0-unstable-2025-05-19";

  src = fetchFromGitHub {
    owner = "cpiber";
    repo = "hyprscroller";
    rev = "de97924b6d1086d84939b6f6688637f7b21d8d80";
    hash = "sha256-m9689UH+w8Z/qP/DKYtzQfIGfiE4jgBAfO+uH34cfNs";
  };

  nativeBuildInputs = [ cmake ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    mv hyprscroller.so $out/lib/libhyprscroller.so

    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    homepage = "https://github.com/cpiber/hyprscroller";
    description = "Hyprland layout plugin providing a scrolling layout like PaperWM";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fortydeux ];
    platforms = lib.platforms.linux;
  };
}
