{ config, pkgs, ... }:

{
  imports = [
  ];

  home.packages = (with pkgs; [
    # kdePackages.yakuake #Drop-down terminal
  ]);
  
  programs = {
    niriswitcher = {
      enable = true;
      settings = {
        keys = {
          modifier = "Alt";
          switch = {
            next = "Tab";
            prev = "Shift+Tab";
          };
        };
        center_on_focus = true;
        appearance = {
          system_theme = "dark";
          icon_size = 64;
        };
      };
    };
  };

  wayland.windowManager = {
    labwc = {
      enable = true;
      menu = [
        {
          menuId = "root-menu";
          label = "";
          icon = "";
          items = [
            {
              label = "BeMenu";
              action = {
                name = "Execute";
                command = "bemenu-run";
              };
            }
            {
              label = "Reconfigure";
              action = {
                name = "Reconfigure";
              };
            }
            {
              label = "Exit";
              action = {
                name = "Exit";
              };
            }
            
          ];
        }
      ];      
    };
  };

}
