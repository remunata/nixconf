{ inputs, ... }:
{
  flake.nixosModules.nvidia =
    { config, pkgs, ... }:

    {
      # Overlay for nvidia video encoding patch
      nixpkgs.overlays = [ inputs.nvidia-patch.overlays.default ];

      # Enable OpenGL
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Use legacy driver cause my gpu is old :)
        package = pkgs.nvidia-patch.patch-nvenc (
          pkgs.nvidia-patch.patch-fbc config.boot.kernelPackages.nvidiaPackages.legacy_580
        );

        # Use proprietary driver
        open = false;

        prime = {
          sync.enable = true;

          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
}
