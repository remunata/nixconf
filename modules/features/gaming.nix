{ ... }:
{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      programs = {
        gamemode.enable = true;

        steam = {
          enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
          extraPackages = with pkgs; [
            gamescope
            SDL2
          ];
          protontricks.enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        steam-run
        mangohud
        heroic
        bottles
        steamtinkerlaunch
        lsfg-vk
        lsfg-vk-ui

        osu-lazer
      ];

      nix.settings = {
        substituters = [ "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
      };
    };
}
