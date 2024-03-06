{config, pkgs, ... }:

{
	wayland.windowManager.hyprland = {
	    extraConfig = ''
	    	### HiDPI XWayland Settings - needed for MS Surface:
	    	### -----------------------------------------------
	    	monitor=,highres,auto,2
	    	env = GDK_SCALE,2
	    	xwayland {
	    	    force_zero_scaling = true
	    	}
	    '';
	};
}






