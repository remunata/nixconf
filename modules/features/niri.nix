{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };

      environment.systemPackages = with pkgs; [
        nautilus
        gnome-keyring

        adw-gtk3
        kdePackages.qt6ct
        libsForQt5.qt5ct

        bibata-cursors
      ];

      # Enable ly as display manager
      services.displayManager.ly = {
        enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings =
          let
            noctaliaExe = lib.getExe self'.packages.noctalia-shell;
          in
          {
            # Environment variables
            environment = {
              QT_QPA_PLATFORMTHEME = "qt6ct";
              EDITOR = "vi";
            };

            # Startup programs
            spawn-at-startup = [
              noctaliaExe
            ];

            # Input & keyboard configuration
            input = {
              keyboard = {
                xkb.layout = "us";
                repeat-delay = 250;
                repeat-rate = 35;
                numlock = true;
              };

              touchpad = {
                natural-scroll = _: { };
                tap = _: { };
              };

              mouse.accel-profile = "flat";
            };

            # Cursor size and theme
            cursor = {
              xcursor-theme = "Bibata-Modern-Classic";
              xcursor-size = 20;

              hide-when-typing = _: { };
              hide-after-inactive-ms = 10000;
            };

            # Layout configuration
            layout = {
              gaps = 16;
              always-center-single-column = _: { };

              focus-ring = {
                width = 2;
                active-color = "#2D2A3E";
                inactive-color = "#140A1D";
              };

              border.off = _: { };

              preset-column-widths = [
                { proportion = 0.5; }
                { proportion = 0.66666667; }
                { proportion = 0.75; }
              ];

              preset-window-heights = [
                { proportion = 0.5; }
                { proportion = 1.; }
              ];
            };

            # Window rules
            window-rules = [
              {
                geometry-corner-radius = 12;
                clip-to-geometry = true;
              }
              {
                matches = [
                  { app-id = "firefox"; }
                  { app-id = "spotify"; }
                ];
                open-maximized = true;
              }
              {
                matches = [
                  { app-id = "wezterm"; }
                  { is-focused = false; }
                ];
                opacity = 0.93;
              }
            ];

            # Prefer no window decoration
            prefer-no-csd = _: { };

            # Don't show hotkey list in startup
            hotkey-overlay.skip-at-startup = _: { };

            # Keybinds configuration
            binds = {
              # WIndow manipulations
              "Mod+Q".close-window = _: { repeat = false; };
              "Mod+F".maximize-column = _: { };
              "Mod+Shift+F".fullscreen-window = _: { };

              "Mod+C".center-column = _: { };
              "Mod+Ctrl+C".center-visible-columns = _: { };

              "Mod+Space".toggle-window-floating = _: { };
              "Mod+Shift+Space".switch-focus-between-floating-and-tiling = _: { };

              "Mod+R".switch-preset-column-width = _: { };
              "Mod+Shift+R".switch-preset-window-height = _: { };

              "Mod+Left".focus-column-left = _: { };
              "Mod+Right".focus-column-right = _: { };
              "Mod+Up".focus-window-up = _: { };
              "Mod+Down".focus-window-down = _: { };

              "Mod+H".focus-column-left = _: { };
              "Mod+L".focus-column-right = _: { };
              "Mod+K".focus-window-up = _: { };
              "Mod+J".focus-window-down = _: { };

              "Mod+Shift+H".move-column-left = _: { };
              "Mod+Shift+L".move-column-right = _: { };
              "Mod+Shift+K".move-window-up = _: { };
              "Mod+Shift+J".move-window-down = _: { };

              "Mod+1".focus-workspace = "w0";
              "Mod+2".focus-workspace = "w1";
              "Mod+3".focus-workspace = "w2";
              "Mod+4".focus-workspace = "w3";
              "Mod+5".focus-workspace = "w4";
              "Mod+6".focus-workspace = "w5";

              "Mod+I".focus-workspace-up = _: { };
              "Mod+U".focus-workspace-down = _: { };

              "Mod+Shift+U".move-column-to-workspace-down = _: { };
              "Mod+Shift+I".move-column-to-workspace-up = _: { };

              "Mod+Shift+1".move-column-to-workspace = "w0";
              "Mod+Shift+2".move-column-to-workspace = "w1";
              "Mod+Shift+3".move-column-to-workspace = "w2";
              "Mod+Shift+4".move-column-to-workspace = "w3";
              "Mod+Shift+5".move-column-to-workspace = "w4";
              "Mod+Shift+6".move-column-to-workspace = "w5";

              "Mod+Ctrl+H".set-column-width = "-5%";
              "Mod+Ctrl+L".set-column-width = "+5%";
              "Mod+Ctrl+J".set-window-height = "-5%";
              "Mod+Ctrl+K".set-window-height = "+5%";

              "Mod+WheelScrollUp".focus-column-left = _: { };
              "Mod+WheelScrollDown".focus-column-right = _: { };
              "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: { };
              "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: { };

              "Mod+BracketLeft".consume-or-expel-window-left = _: { };
              "Mod+BracketRight".consume-or-expel-window-right = _: { };

              "Mod+Comma".consume-window-into-column = _: { };
              "Mod+Period".expel-window-from-column = _: { };

              # spawn programs
              "Mod+Return".spawn = "wezterm";
              "Mod+W".spawn = "firefox";
              "Mod+E".spawn-sh = "wezterm -e yazi";

              # Screenshot
              "Print".screenshot = _: { };
              "Ctrl+Print".screenshot-screen = _: { };
              "Alt+Print".screenshot-window = _: { };

              # Noctalia keybinds
              "Alt+Space".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
              "Mod+Shift+Period".spawn-sh = "${noctaliaExe} ipc call settings toggle";
              "Mod+Alt+L".spawn-sh = "${noctaliaExe} ipc call lockScreen lock";
              "Mod+P".spawn-sh = "${noctaliaExe} ipc call systemMonitor toggle";
              "Mod+V".spawn-sh = "${noctaliaExe} ipc call launcher clipboard";
              "Mod+Y".spawn-sh = "${noctaliaExe} ipc call calendar toggle";
              "Mod+N".spawn-sh = "${noctaliaExe} ipc call notifications toggleHistory";
              "Mod+Backspace".spawn-sh = "${noctaliaExe} ipc call sessionMenu toggle";

              # Media keybinds
              "XF86AudioRaiseVolume".spawn-sh = "${noctaliaExe} ipc call volume increase";
              "XF86AudioLowerVolume".spawn-sh = "${noctaliaExe} ipc call volume decrease";
              "XF86AudioMute".spawn-sh = "${noctaliaExe} ipc call volume muteOutput";
              "XF86AudioPlay".spawn-sh = "${noctaliaExe} ipc call volume playPause";
              "XF86AudioNext".spawn-sh = "${noctaliaExe} ipc call volume next";
              "XF86AudioPrev".spawn-sh = "${noctaliaExe} ipc call volume previous";
              "Mod+M".spawn-sh = "${noctaliaExe} ipc call media toggle";

              # Brightness
              "XF86MonBrightnessUp".spawn-sh = "${noctaliaExe} ipc call brightness increase";
              "XF86MonBrightnessDown".spawn-sh = "${noctaliaExe} ipc call brightness decrease";

              # Miscellaneous
              "Mod+O".toggle-overview = _: { repeat = false; };
            };

            # Predifined workspaces
            workspaces = {
              "w0" = _: { };
              "w1" = _: { };
              "w2" = _: { };
              "w3" = _: { };
              "w4" = _: { };
              "w5" = _: { };
            };

            # Prove xwayland-satellite path for niri
            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          };
      };
    };
}
