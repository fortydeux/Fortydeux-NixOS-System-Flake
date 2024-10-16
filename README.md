# README

**Author:** Fortydeux

## Disclaimer and intention:

This is a work-in-progress personal NixOS Flake using Plasma and Hyprland for desktop/wm environments (and more recent additions of River, Sway, and Wayfire, which have usable, but not elaborate, configs).

As such, it is mostly intended for personal use, but made public for the sake of sharing and easy reference. 

Feel free to use my setup or any parts of it that you find useful. 

I am still very much learning Nix along with many other things, so please leave feedback for any bugs, better practices, corrections, or appreciation as indicated. 

...that being said, please don't expect speedy updates or support, as this is just a personal/hobby endeavor.

It is also possible that I may leave this flake in a broken state while I'm working on things, so try it at your own risk.

![Hyprland Screenshot](https://github.com/fortydeux/Fortydeux-NixOS-System-Flake/blob/main/media/fortyflake-hyprland-screenshot.png)

### My intention with all of these Window Managers/Compositors was to make reasonably nice, usable configs, without changing too much, so that I (and others with the magic of Nix Flakes) can experience how these WMs operate close-ish to Vanilla, but with some of the basic QOL additions already in place.

### I have also opted to leave most of the config files in their raw format, and write them to the $HOME/.config/ directory using home-manager's home.files function. This makes it easier for myself and others to view and edit easily without the surrounding .nix syntax, and also makes them easier to share to non-Nix machines.


## Install

With disclaimers and descriptors out of the way, the build instructions would go something like this:

### First you want to have a fresh install of NixOS, or one that you don't mind messing up

### Then go ahead and follow these instructions:

git clone <this-repo> (I am cloning into a new folder called 'fortyflake,' you can change the folder, but will need to change your following commands to suit):
```
git clone https://github.com/fortydeux/Fortydeux-NixOS-System-Flake.git ~/fortyflake
```

then cd into Flake directory and generate your hardware-configuration into <flake-dir>/nixos-config/hosts/blackfin/ /note: you could also copy this from your '/etc/nixos/hardware-configuration.nix'/ (I am managing multiple machines with this flake, and I suggest building "blackfin" or "blacktetra" hosts, unless you are on very specific hardware: archerfish host is tailored to a MS Surface Book 2 device with HighDPI display, pufferfish is an iMac with some specific hardware modules enabled as well).
> **Note:** This step is very important! A wrong hardware config can break your system, although with the beauty of NixOS you should still be fine to roll back by booting into your previous build.

```
cd ~/fortyflake

sudo nixos-generate-config --show-hardware-config > nixos-config/hosts/blackfin/hardware-configuration.nix
```

Change any names and config settings you need to in flake.nix and nixos-config/configuration.nix:
 - This part is significantly easier now that I've split up the host configs, so all you need to do is comb through the configs and change anything you want/need prior to building.
 - Note: You may obviously wish to change the username and device name, but be warned this may break some paths in the config, so I would recommend building first, and attending to this later, or doing a very thorough job when changing. 

*** Once these steps are done, you are ready to build the flake

- First build the system with "nixos-rebuild" and "--flake" option: 

```
cd ~/fortyflake

sudo nixos-rebuild switch --flake .#blackfin-nixos
```
- Then install home-manager and build the home-manager configuration with the following command:
```
nix run home-manager/master -- switch --flake .#fortydeux@blackfin-nixos
```

Assuming everything now builds correctly, you should have a very decent system running KDE Plasma Wayland Desktop, plus my (I think quite nice) customized Hyprland & Waybar setup (and now basic configs for River, Sway, and Wayfire too)

I spend most of my time in Hyprland (and, increasingly River) but keep Plasma for backup fringe uses.

For Hyprland, you will likely want to customize the startup launch programs and some keybindings, but see below for my defaults:

- You'll find these within home-manager/dotfiles/hypr/hyprland.conf

- Startup launch programs are prefixed by "exec-once"

- Check through hyprland.conf to see a full list of my keybindings... I've kept many of them close to the original hyprland bindings, so I (or you) won't be totally lost on a fresh install

### Hyprland navigation commands:
- **SUPER+M**: quit hyprland
- **SUPER+ESC**: restart waybar (this is the default bar in my hyprland setup, although I may be adding Aylur's ags eventually)
- **CTRL+SPACE**: fuzzel app launcher - quickly search and open any app on the system (see configuration.nix and home.nix for available apps)
- **CTRL+C**: Closes active window
- **CTRL+Q**: Launches default terminal emulator (kitty)
- **CTRL+W**: Launches Drun application launcher - shows list of all apps, ESC to close
- Switch virtual workspaces with 3-finger touchpad swipe, also **SUPER+1,2,3,...**, also **CTRL+SUPER+<right and left arrow keys>**
- **SUPER+F**: toggle fullscreen (works very nicely with SUPER+<arrow-keys> to switch apps within current workspace while staying in fullscreen view)
- **SUPER+H**: toggle maximize (also works very nicely with SUPER+<arrow-keys> to switch apps within current workspace while staying in maximized view)
- **SUPER+<arrow-keys>**: switch active apps within current workspace
- **SUPER+SHIFT+Left-click+drag**: resize window
- **SUPER+Left-click+drag**: move window
- **SUPER+V**: toggle window float
- **SUPER+J**: vertical / horizontal split
- **SUPER+SHIFT+Z/C**: Animated wallpapers with credit to taylor8534
- **SUPER+SHIFT+X**: back to default static wallpaper

...there are plenty more, but that's enough to get started - again, see hyprland.conf for the full list and to customize your setup. Remember, this needs to be done within the flake and written with home-manager unless you change that behavior (which is recommended for lots of editing)

### Notes on other window managers
I have made the major keybindings mostly the same for Wayfire and Sway. River operates a little differently, using a tag system instead of standard workspaces, which I find very nice for certain workflows. Nevertheless, the same keybindings will get you most of the way on River too. Just check their respective config files for the rest, or to change them to your own preferences.

### Important note about dotfiles within this Flake:
- I have home-manager managing the dotfiles for Hyprland, and a few other key applications where I have custom setups that I want to reproduce between different machines.
- This means that to make a change, you need to edit the config file within the flake (home-manager/dotfiles) then do a "home-manager switch" to write the updated file to $HOME.
- You may even need to reboot or CTRL+M to quit Hyprland and log back in to see your changes.
- This is a MUCH more cumbersome workflow, especially for Hyprland where normally saving hyprland.conf would trigger an automatic reload of the config file, giving immediate feedback of changes.
- Therefore, if you are making a lot of changes, you may want to stop Home-manager from managing these files (comment out and run switch command), and go back to editing them directly within your $HOME directory until most of your edits are done, at which time you may choose to copy them back into home-manager/dotfiles and resume home-manager's management of them.

Please contact me with any questions/comments. Thanks! 

Also many **thanks** to all those I've learned from and whose projects I am using as full packages, or just bits of code that I've learned or borrowed.

You all have contributed to my learning journey, and building the most fun and productive desktop/wm environment (for my own needs and preferences) in which I've ever had the pleasure to work.

A totally non-comprehensive list:
- The NixOS team
- Vaxry (creator of Hyprland)
- All the Linux Unplugged/Jupiter Broadcasting guys (and community), who got me started on both NixOS and Hyprland - both decisions I've questioned at times, but ultimately find myself better off
- LibrePhoenix - for some of the best NixOS tutorials for a someone like me... as a nurse by trade rather than a developer, I needed a different approach
- ChatGPT - ...um, yeah. It turns out as a nurse, you don't find many friends who are into Linux, Nix, and Hyprland... so having 'someone' to bug with questions repeatedly at all hours, short of a real-world mentor, is pretty invaluable.
- taylor85345 - for some really nice hyprland theming that helped me out early on, although I ultimately ditched ewww and went with my own spin on waybar, you'll still find easter eggs of taylors' awesome garden and neon/cyber changing wallpapers including video segments if you are running my system in Hyprland and hit SUPER+CTRL+Z or SUPER+CTRL+C... SUPER+CTRL+X will take you back to my static desktop
