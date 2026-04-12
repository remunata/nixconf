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

            # Monitor configuration
            outputs = {
              "eDP-1" = {
                mode = "1920x1080@60.000";
                scale = 1.;
                position = _: {
                  props = {
                    x = 1920;
                    y = 0;
                  };
                };
              };

              "HDMI-A-1" = {
                mode = "1920x1080@143.997";
                scale = 1.;
                position = _: {
                  props = {
                    x = 0;
                    y = 0;
                  };
                };

                focus-at-startup = _: { };
              };
            };

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
              gaps = 12;
              center-focused-column = "never";

              focus-ring = {
                width = 5;
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
                  { app-id = "zen"; }
                  { app-id = "spotify"; }
                  { app-id = "heroic"; }
                  { app-id = "steam"; }
                  { app-id = "wezterm"; }
                ];
                open-maximized = true;
              }
              {
                matches = [
                  { app-id = "Alacritty"; }
                  { app-id = "wezterm"; }
                  { app-id = "ghostty"; }
                  { is-focused = false; }
                ];
                opacity = 0.93;
                draw-border-with-background = false;

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

              "Mod+1".focus-workspace = 1;
              "Mod+2".focus-workspace = 2;
              "Mod+3".focus-workspace = 3;
              "Mod+4".focus-workspace = 4;
              "Mod+5".focus-workspace = 5;
              "Mod+6".focus-workspace = 6;
              "Mod+7".focus-workspace = 7;
              "Mod+8".focus-workspace = 8;
              "Mod+9".focus-workspace = 9;

              "Mod+U".focus-workspace-up = _: { };
              "Mod+D".focus-workspace-down = _: { };

              "Mod+Shift+D".move-column-to-workspace-down = _: { };
              "Mod+Shift+U".move-column-to-workspace-up = _: { };

              "Mod+Shift+1".move-column-to-workspace = 1;
              "Mod+Shift+2".move-column-to-workspace = 2;
              "Mod+Shift+3".move-column-to-workspace = 3;
              "Mod+Shift+4".move-column-to-workspace = 4;
              "Mod+Shift+5".move-column-to-workspace = 5;
              "Mod+Shift+6".move-column-to-workspace = 6;
              "Mod+Shift+7".move-column-to-workspace = 7;
              "Mod+Shift+8".move-column-to-workspace = 8;
              "Mod+Shift+9".move-column-to-workspace = 9;

              "Mod+Ctrl+Left".set-column-width = "-5%";
              "Mod+Ctrl+Right".set-column-width = "+5%";
              "Mod+Ctrl+Down".set-window-height = "-5%";
              "Mod+Ctrl+Up".set-window-height = "+5%";

              "Mod+Ctrl+L".focus-monitor-right = _: { };
              "Mod+Ctrl+H".focus-monitor-left = _: { };
              "Mod+Ctrl+K".focus-monitor-up = _: { };
              "Mod+Ctrl+J".focus-monitor-down = _: { };

              "Mod+Ctrl+Shift+L".move-column-to-monitor-right = _: { };
              "Mod+Ctrl+Shift+H".move-column-to-monitor-left = _: { };
              "Mod+Ctrl+Shift+K".move-column-to-monitor-up = _: { };
              "Mod+Ctrl+Shift+J".move-column-to-monitor-down = _: { };

              "Mod+WheelScrollUp".focus-column-left = _: { };
              "Mod+WheelScrollDown".focus-column-right = _: { };
              "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: { };
              "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: { };

              "Mod+BracketLeft".consume-or-expel-window-left = _: { };
              "Mod+BracketRight".consume-or-expel-window-right = _: { };

              "Mod+Comma".consume-window-into-column = _: { };
              "Mod+Period".expel-window-from-column = _: { };

              # spawn programs
              "Mod+Return".spawn = "ghostty";
              "Mod+W".spawn = "zen";
              "Mod+E".spawn-sh = "ghostty -e yazi";

              # Screenshot
              "Print".screenshot = _: { };
              "Ctrl+Print".screenshot-screen = _: { };
              "Alt+Print".screenshot-window = _: { };

              # Noctalia keybinds
              "Alt+Space".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
              "Mod+Shift+Period".spawn-sh = "${noctaliaExe} ipc call settings toggle";
              "Mod+M".spawn-sh = "${noctaliaExe} ipc call controlCenter toggle";
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

              # Brightness
              "XF86MonBrightnessUp".spawn-sh = "${noctaliaExe} ipc call brightness increase";
              "XF86MonBrightnessDown".spawn-sh = "${noctaliaExe} ipc call brightness decrease";

              # Miscellaneous
              "Mod+O".toggle-overview = _: { repeat = false; };
            };

            # Prove xwayland-satellite path for niri
            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          };
      };
    };
}
