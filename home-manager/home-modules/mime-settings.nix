{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;
  };

  home.activation = {
    mimeAppsUpdate = {
      after = [ "linkGeneration" ];
      before = [ "reloadSystemd" ];
      data = ''
        echo "Updating MIME and desktop databases..."
        mkdir -p ~/.local/share/mime
        mkdir -p ~/.local/share/applications
              
        ${pkgs.shared-mime-info}/bin/update-mime-database ~/.local/share/mime
        ${pkgs.desktop-file-utils}/bin/update-desktop-database ~/.local/share/applications
      '';
    };
  };

  # Ensure desktop entries are properly registered
  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      genericName = "Text Editor";
      exec = "code %F";
      terminal = false;
      type = "Application";
      categories = [ "Development" "TextEditor" ];
      mimeType = [ "text/plain" "text/markdown" "text/html" "text/xml" "application/json" ];
    };
    
    helix = {
      name = "Helix";
      genericName = "Text Editor";
      exec = "helix %F";
      terminal = true;
      type = "Application";
      categories = [ "Development" "TextEditor" ];
      mimeType = [ "text/plain" "text/markdown" "text/html" "text/xml" "application/json" ];
    };

    "libreoffice-writer" = {
      name = "LibreOffice Writer";
      genericName = "Word Processor";
      exec = "libreoffice --writer %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "WordProcessor" ];
      mimeType = [
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.oasis.opendocument.text"
      ];
    };

    "libreoffice-calc" = {
      name = "LibreOffice Calc";
      genericName = "Spreadsheet";
      exec = "libreoffice --calc %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "Spreadsheet" ];
      mimeType = [
        "application/vnd.ms-excel"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.oasis.opendocument.spreadsheet"
      ];
    };

    "libreoffice-impress" = {
      name = "LibreOffice Impress";
      genericName = "Presentation";
      exec = "libreoffice --impress %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "Presentation" ];
      mimeType = [
        "application/vnd.ms-powerpoint"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.oasis.opendocument.presentation"
      ];
    };

    "mpv" = {
      name = "mpv Media Player";
      genericName = "Multimedia player";
      exec = "mpv --player-operation-mode=pseudo-gui -- %F";
      terminal = false;
      type = "Application";
      categories = [ "AudioVideo" "Audio" "Video" "Player" ];
      mimeType = [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "application/vnd.adobe.flash.movie"
      ];
    };

    "org.kde.okular" = {
      name = "Okular";
      genericName = "Document Viewer";
      exec = "okular %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "Viewer" ];
      mimeType = [
        "application/pdf"
        "application/epub+zip"
        "application/x-mobipocket-ebook"
      ];
    };

    "nnn" = {
      name = "nnn";
      genericName = "File Manager";
      exec = "nnn %F";
      terminal = true;
      type = "Application";
      categories = [ "System" "FileManager" ];
      mimeType = [ "inode/directory" ];
    };

    "appflowy" = {
      name = "AppFlowy";
      genericName = "Note Taking";
      exec = "appflowy %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "ProjectManagement" "Utility" ];
      mimeType = [ "text/markdown" "text/plain" ];
    };

    "joplin-desktop" = {
      name = "Joplin";
      genericName = "Note Taking";
      exec = "joplin-desktop %F";
      terminal = false;
      type = "Application";
      categories = [ "Office" "TextEditor" "Utility" ];
      mimeType = [ "text/markdown" "text/plain" ];
    };

    "signal-desktop" = {
      name = "Signal";
      genericName = "Messenger";
      exec = "signal-desktop %U";
      terminal = false;
      type = "Application";
      categories = [ "Network" "InstantMessaging" "Chat" ];
    };

    "super-productivity" = {
      name = "Super Productivity";
      genericName = "Task Manager";
      exec = "super-productivity %U";
      terminal = false;
      type = "Application";
      categories = [ "Office" "ProjectManagement" "Utility" ];
    };

    "ticktick" = {
      name = "TickTick";
      genericName = "Task Manager";
      exec = "ticktick %U";
      terminal = false;
      type = "Application";
      categories = [ "Office" "ProjectManagement" "Utility" ];
    };

    "zed" = {
      name = "Zed";
      genericName = "Text Editor";
      exec = "zed %F";
      terminal = false;
      type = "Application";
      categories = [ "Development" "TextEditor" ];
      mimeType = [ "text/plain" "text/markdown" "text/html" "text/xml" "application/json" ];
    };

    "warp" = {
      name = "Warp";
      genericName = "Terminal Emulator";
      exec = "warp-terminal";
      terminal = false;
      type = "Application";
      categories = [ "System" "TerminalEmulator" ];
    };

    "zellij" = {
      name = "Zellij";
      genericName = "Terminal Multiplexer";
      exec = "zellij";
      terminal = true;
      type = "Application";
      categories = [ "System" "TerminalEmulator" ];
    };

    "org.kde.gwenview" = {
      name = "Gwenview";
      genericName = "Image Viewer";
      exec = "gwenview %F";
      terminal = false;
      type = "Application";
      categories = [ "Graphics" "Viewer" ];
      mimeType = [
        "image/jpeg"
        "image/png"
        "image/gif"
        "image/webp"
        "image/tiff"
        "image/bmp"
      ];
    };

    "org.kde.dolphin" = {
      name = "Dolphin";
      genericName = "File Manager";
      exec = "dolphin %F";
      terminal = false;
      type = "Application";
      categories = [ "System" "FileManager" ];
      mimeType = [ "inode/directory" ];
    };

    "org.kde.ark" = {
      name = "Ark";
      genericName = "Archive Manager";
      exec = "ark %F";
      terminal = false;
      type = "Application";
      categories = [ "Utility" "Archiving" ];
      mimeType = [
        "application/zip"
        "application/x-7z-compressed"
        "application/x-rar"
        "application/x-tar"
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Documents
      "application/pdf" = "org.kde.okular.desktop";
      "text/plain" = "code.desktop";
      "text/markdown" = "code.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "code.desktop";
      "application/json" = "code.desktop";
      
      # Images
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/gif" = "org.kde.gwenview.desktop";
      "image/webp" = "org.kde.gwenview.desktop";
      
      # Video
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      
      # Directories
      "inode/directory" = "org.kde.dolphin.desktop";
      
      # Archives
      "application/zip" = "org.kde.ark.desktop";
      "application/x-7z-compressed" = "org.kde.ark.desktop";
      "application/x-rar" = "org.kde.ark.desktop";
      "application/x-tar" = "org.kde.ark.desktop";
      
      # Office Documents
      "application/msword" = "libreoffice-writer.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
      "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
      "application/vnd.ms-excel" = "libreoffice-calc.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice-calc.desktop";
      "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";
      "application/vnd.oasis.opendocument.presentation" = "libreoffice-impress.desktop";
      
      # Additional Document Formats
      "application/epub+zip" = "org.kde.okular.desktop";
      "application/x-mobipocket-ebook" = "org.kde.okular.desktop";
      "application/vnd.adobe.flash.movie" = "mpv.desktop";
    };

    associations = {
      added = {
        # Documents
        "application/pdf" = ["org.kde.okular.desktop" "org.pwmt.zathura.desktop"];
        "text/plain" = ["code.desktop" "helix.desktop" "nvim.desktop"];
        "text/markdown" = ["code.desktop" "org.kde.okular.desktop" "helix.desktop" "nvim.desktop"];
        "text/html" = ["firefox.desktop" "code.desktop" "helix.desktop"];
        "text/xml" = ["code.desktop" "helix.desktop" "nvim.desktop"];
        "application/json" = ["code.desktop" "helix.desktop" "nvim.desktop"];
        
        # Images
        "image/jpeg" = ["org.kde.gwenview.desktop" "imv.desktop"];
        "image/png" = ["org.kde.gwenview.desktop" "imv.desktop"];
        "image/gif" = ["org.kde.gwenview.desktop" "imv.desktop"];
        "image/webp" = ["org.kde.gwenview.desktop" "imv.desktop"];
        
        # Video
        "video/mp4" = ["mpv.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "video/webm" = ["mpv.desktop"];
        
        # Directories
        "inode/directory" = ["org.kde.dolphin.desktop" "thunar.desktop" "nnn.desktop"];
        
        # Archives
        "application/zip" = ["org.kde.ark.desktop" "thunar.desktop"];
        "application/x-7z-compressed" = ["org.kde.ark.desktop" "thunar.desktop"];
        "application/x-rar" = ["org.kde.ark.desktop" "thunar.desktop"];
        "application/x-tar" = ["org.kde.ark.desktop" "thunar.desktop"];
        
        # Office Documents
        "application/msword" = ["libreoffice-writer.desktop" "org.kde.okular.desktop"];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["libreoffice-writer.desktop" "org.kde.okular.desktop"];
        "application/vnd.oasis.opendocument.text" = ["libreoffice-writer.desktop" "org.kde.okular.desktop"];
        "application/vnd.ms-excel" = ["libreoffice-calc.desktop"];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["libreoffice-calc.desktop"];
        "application/vnd.oasis.opendocument.spreadsheet" = ["libreoffice-calc.desktop"];
        "application/vnd.ms-powerpoint" = ["libreoffice-impress.desktop" "org.kde.okular.desktop"];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["libreoffice-impress.desktop" "org.kde.okular.desktop"];
        "application/vnd.oasis.opendocument.presentation" = ["libreoffice-impress.desktop" "org.kde.okular.desktop"];
        
        # Additional Document Formats
        "application/epub+zip" = ["org.kde.okular.desktop" "org.pwmt.zathura.desktop"];
        "application/x-mobipocket-ebook" = ["org.kde.okular.desktop"];
        "application/vnd.adobe.flash.movie" = ["mpv.desktop"];
      };
    };
  };
} 
