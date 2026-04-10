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

        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
