{ ... }:
{
  flake.nixosModules.shell =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;

        shellAbbrs = {
          gco = "git checkout";
          gcl = "git clone";
          ga = "git add";
          gcmsg = "git commit -m";
          gp = "git push";
          gs = "git status";
        };

        shellAliases = {
          l = "ls -l";
          la = "ls -la";
          q = "exit";
          c = "clear";
          nrs = "sudo nixos-rebuild switch --flake .";
        };
      };

      # Set default shell to fish
      users.defaultUserShell = pkgs.fish;

      # Starship prompt
      programs.starship = {
        enable = true;
        transientPrompt.enable = true;
      };

      # Zoxide for better cd experience
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        flags = [
          "--cmd cd"
        ];
      };
    };
}
