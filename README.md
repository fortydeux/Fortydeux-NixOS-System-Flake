This is a work-in-progress personal NixOS Flake using Plasma and Hyprland for desktop/wm environments. 

As such, it is mostly intended for personal use, but public for the sake of sharing and easy reference. 

Feel free to use my setup or any parts of it that you find useful. 

I'm still very much learning Nix along with many other things, so please leave feedback for any bugs, better practices, corrections, or appreciation that you may notice. 

...that being said, please don't expect speedy updates, as this is just a personal/hobby endeavor. 


This Flake is not fully ready to build yet, but essentially the build instructions would go something like this: 

git clone <this-repo>

cd into Flake directory

generate your hardware config into <flake-dir>/nixos-config (see NixOS documentation for this command)

(change any names you need to in flake.nix and nixos-config/configuration.nix)

sudo nixos-rebuild switch --flake .#fortydeux-nixos (or chosen system name)

(change anything you need to in home-manage/home.nix)

home-manager switch --flake .#fortydeux

If everything builds correctly, you should have a very decent system running KDE Plasma desktop with Wayland or x11 options and Hyprland

I spend most of my time in Hyprland, but keep Plasma for backup fringe uses. 

For Hyprland, you will likely want to customize the startup launch programs and some keybindings:
You'll find these within home-manager/dotfiles/hypr/hyprland.conf 
Startup launch programs are prefixed by "exec-once"
Check through hyprland.conf to see a full list of my keybindings...
I've kept many of them close to the original hyprland bindings, so I won't be totally lost on a fresh install
SUPER+M = quit hyprland
SUPER+ESC = restart waybar (this is the default bar in my hyprland setup, although I may be adding Aylur's ags eventually)
CTRL+SPACE = fuzzel app launcher - quickly search and open any app on the system (see configuration.nix and home.nix for available apps)
CTRL+C = Closes active window
CTRL+Q = Launches default terminal emulator (kitty)
CTRL+W = Launches Drun application launcher - shows list of all apps, ESC to close
Switch virtual workspaces with 3-finger touchpad swipe, also SUPER+1,2,3,...), also CTRL+SUPER+<right and left arrow keys>
SUPER+F = toggle fullscreen (works very nicely with SUPER+<arrow-keys> to switch apps within current workspace while staying in fullscreen view)
SUPER+<arrow-keys> = switch active apps within current workspace
...there are plenty more, but that's enough to get started - again, see hyprland.conf for the full list and tp customize your setup. 

Another important note about dotfiles within this Flake:
I have home-manager managing the dotfiles for Hyprland, and a few other key applications where I have custom setups that I want to reproduce between different machines...
The potential downside of this, is that home-manager locks these files where they are written to within $HOME directory. 
This means that to make a change, you need to edit the config file within the flake (home-manager/dotfiles) then do a "home-manager switch" to write the updated file to $HOME
and you may even need to reboot or CTRL+M to quit Hyprland and log back in to see your changes...
This is a much more cumbersome workflow, especially for Hyprland where normally saving hyprland.conf triggers an automatic reload of the file, giving immediate feedback of changes. 
Therefore, if you are making a lot of changes, you may want tp stop Home-manager from managing these files (comment out and run switch command), and go back to editing them directly within your $HOME directory until most of your edits are done, at which time you may choose to copy them back into home-manager/dotfiles and resume home-manager's management of them. 

Please contact me with any questions/comments. Thanks! 

Also many thanks to all those I've learned from and whose projects I am using as full packages, or just bits of code that I've learned or borrowed.
You all have contributed to my learning journey, and building the most productive desktop/wm evironment (for my own needs and preferences) in which I've ever had the pleasure to work.
A totally non-comprehensive list:
The NixOS team
Vaxry (creator of Hyprland)
All the Linux Unplugged/Jupiter Broadcasting guys (and community), who got me started on both NixOS and Hyprland - both decisions I've questioned at times, but ultimately find myself better off 
LibrePhoenix - for some of the best NixOS tutorials for a someone like me, as a nurse by trade rather than a developer, I needed a different approach
ChatGPT - ...um, yeah. It turns out as a nurse, you don't find many friends who are into Linux, Nix, and Hyprland... so having 'someone' to bug with questions repeatedly at all hours, short of a real-world mentor, is pretty invaluable.
taylor85345 - for some really nice hyprland theming, although I ultimately ditched ewww and went with my own spin on waybar, you'll still find easter eggs of taylors's awesome garden and neon/cyber changing wallpapers including video segments if you are running my system and hit SUPER+CTRL+Z or SUPER+CTRL+C... SUPER+CTRL+X will take you back to my static desktop 
Aylur - although I haven't switched over to ags yet, I'm quite inspired by this project, and also appreciate the Nix support
