{ ... }:
{
  flake.nixosModules.coding =
    { ... }:
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
    };
}
