{ ... }:
{
  flake.nixosModules.user =
    { ... }:
    {
      # Define a default user account.
      users.users.remunata = {
        isNormalUser = true;
        description = "remunata";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "input"
          "uinput"
        ];
      };

      nix.extraOptions = ''
        trusted-users = root remunata
      '';
    };
}
