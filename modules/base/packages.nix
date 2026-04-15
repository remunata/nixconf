{ inputs, ... }:
{
  flake.nixosModules.packages =
    { lib, pkgs, ... }:
    {
      # System packages
      environment.systemPackages = with pkgs; [
        inputs.remuvim.packages.${pkgs.stdenv.hostPlatform.system}.neovim
        wget
        wget2
        wl-clipboard
        jq
        fd
        fzf
      ];

      # Additional fonts
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans

        nerd-fonts.jetbrains-mono
        nerd-fonts.hack
      ];

      # Git configuration
      programs.git = {
        enable = true;
        config = {
          init.defaultBranch = "main";
          user = {
            name = "Mahendra Dinata";
            email = "remdinata@gmail.com";
          };
        };
      };

      # Allow some unfree packages
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "spotify"
          "discord"
          "steam"
          "steam-unwrapped"
          "obsidian"
          "postman"
          "unrar"
        ];
    };
}
