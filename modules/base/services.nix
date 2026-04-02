{ ... }:
{
  flake.nixosModules.services =
    { ... }:
    {
      # Enable gvfs for trash management
      services.gvfs.enable = true;

      # Enable udisks2 for auto mount drive
      services.udisks2.enable = true;
    };
}
