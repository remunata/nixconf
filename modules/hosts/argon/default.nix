{ self, inputs, ... }:
{
  flake.nixosConfigurations.argon = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.argonConfiguration
    ];
  };
}
