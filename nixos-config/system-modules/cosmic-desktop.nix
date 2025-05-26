# cosmic-desktop.nix
{ inputs, config, pkgs, ... }:

{
  # nix.settings = {
  #   substituters = [ "https://cosmic.cachix.org/" ];
  #   trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  # };

  # imports = [
  #   inputs.nixos-cosmic.nixosModules.default
  # ];

  services.desktopManager.cosmic.enable = true;
}
