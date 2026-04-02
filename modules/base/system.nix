{ ... }:
{
  flake.nixosModules.system =
    { ... }:
    {
      # Define hostname
      networking.hostName = "argon";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set time zone
      time.timeZone = "Asia/Jakarta";

      # Select internationalisation properties
      i18n.defaultLocale = "en_US.UTF-8";

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # Bluetooth.
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      # Enable gvfs for trash management
      services.gvfs.enable = true;

      # Security.
      security = {
        rtkit.enable = true;
        polkit.enable = true;
      };

      # Enable nix command and flakes
      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        extraOptions = ''
          keep-outputs = true
          keep-derivations = true
        '';
      };

      # Block sound module for dell laptop.
      boot.blacklistedKernelModules = [ "snd_soc_avs" ];
    };
}
