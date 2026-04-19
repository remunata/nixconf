{ ... }:
{
  flake.nixosModules.kanata =
    { ... }:
    {
      services.kanata = {
        enable = true;
        keyboards."default".config = ''
          (defsrc
            caps
          )

          (defalias
            escctrl (tap-hold 100 100 esc lctrl)
          )

          (deflayer base
            @escctrl
          )
        '';
      };
    };
}
