{ ... }:
{
  flake.nixosModules.firefox =
    { pkgs, ... }:
    {
      # Install firefox.
      programs.firefox.enable = true;

      environment.systemPackages = with pkgs; [
        pywalfox-native
      ];
    };
}
