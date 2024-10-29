{ inputs, ... }: 

{ # Determinate.nix

  # Load the Determinate module
  imports = [
    inputs.determinate.nixosModules.default
  ];

}
