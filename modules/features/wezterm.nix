{ self, inputs, ... }:
{
  flake.nixosModules.wezterm =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.wezterm = inputs.wrapper-modules.wrappers.wezterm.wrap {
        inherit pkgs;

        "wezterm.lua".content = ''
          local wezterm = require 'wezterm'
          local config = wezterm.config_builder()

          config.enable_tab_bar = false
          config.window_padding = {
            left = 25,
            right = 25,
            top = 15,
            bottom = 15,
          }

          config.color_scheme = 'terafox'

          return config
        '';
      };
    };
}
