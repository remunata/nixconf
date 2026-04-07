{ ... }:
{
  flake.nixosModules.recording =
    { pkgs, ... }:
    {
      # Enable gpu screen recorder
      programs.gpu-screen-recorder.enable = true;

      # Screen recorder gui
      environment.systemPackages = with pkgs; [
        gpu-screen-recorder-gtk # GUI app
      ];
    };
}
