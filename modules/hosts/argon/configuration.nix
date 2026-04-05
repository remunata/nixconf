{ self, ... }:
{
  flake.nixosModules.argonConfiguration =
    { ... }:

    {
      imports = [
        self.nixosModules.argonHardware

        # Base
        self.nixosModules.nvidia
        self.nixosModules.packages
        self.nixosModules.services
        self.nixosModules.system
        self.nixosModules.user

        # Features
        self.nixosModules.alacritty
        self.nixosModules.coding
        self.nixosModules.firefox
        self.nixosModules.gaming
        self.nixosModules.niri
        self.nixosModules.no-config
        self.nixosModules.shell
        self.nixosModules.spicetify
        self.nixosModules.wezterm
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?

    };
}
