{ inputs, ... }:
{
  flake.nixosModules.spicetify =
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        inputs.spicetify-nix.nixosModules.spicetify
      ];

      programs.spicetify = {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
        ];

        theme = spicePkgs.themes.text;
      };
    };
}
