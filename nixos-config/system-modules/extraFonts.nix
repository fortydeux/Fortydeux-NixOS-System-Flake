{ pkgs, ... }: 

{   
  ### Fonts
  fonts.fontconfig.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
