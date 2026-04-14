{ inputs, ... }:
{
  flake.nixosModules.no-config =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        qimgv
        evince
        mpv
        discord
        keepassxc
        yazi
        libreoffice
        pavucontrol
        btop
        obsidian
        aria2

        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
