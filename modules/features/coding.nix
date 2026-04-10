{ ... }:
{
  flake.nixosModules.coding =
    { pkgs, ... }:
    {
      # Enable docker
      virtualisation.docker.enable = true;

      # Enable direnv
      programs.direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };

      # Programs for coding
      environment.systemPackages = with pkgs; [
        postman
        dbeaver-bin
        ghostty
      ];
    };
}
