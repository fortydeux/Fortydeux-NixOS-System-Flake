{ config, lib, pkgs, ... }:

let
  # Patch to fix patchelf issues with nixpkgs version
  patchelfFixes = pkgs.patchelfUnstable.overrideAttrs (_finalAttrs: _previousAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "Patryk27";
      repo = "patchelf";
      rev = "527926dd9d7f1468aa12f56afe6dcc976941fedb";
      sha256 = "sha256-3I089F2kgGMidR4hntxz5CKzZh5xoiUwUsUwLFUEXqE=";
    };
  });
  # Patched version
  pcloudFixes = pkgs.pcloud.overrideAttrs (_finalAttrs:previousAttrs: {
    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ patchelfFixes ];
  });
  # Unrelated to above - this calls pcloud-package.nix to build pcloud directly, rather than waiting for nixpkgs-unstable to update
  pcloud = pkgs.callPackage ./pcloud-package.nix {};
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    # pcloudFixes #Patched version
    pcloud #pcloud-package.nix local build version
  ];
}
