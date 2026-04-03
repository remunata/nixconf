{ ... }:
{
  flake.nixosModules.coding =
    { ... }:
    {
      # Enable docker
      virtualisation.docker.enable = true;
    };
}
