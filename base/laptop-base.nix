{
  # Laptop packages, for things like power profiles
  # See https://nixos.wiki/wiki/Laptop
  imports = [
    ./default.nix
  ];

  # Power Management with tlp
  powerManagement.enable = true;
  services.thermald.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      # https://www.reddit.com/r/thinkpad/comments/og5anr/til_battery_charging_thresholds_best_practices/
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 78; # 78 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 85; # 85 and above it stops charging
    };
  };

  # Keyboard home row mods
  # https://github.com/dreamsofcode-io/home-row-mods?tab=readme-ov-file
  # https://github.com/elliottminns/dotfiles/blob/a204380f1b256ad726980fe8694106ef486594e6/nix/configuration.nix#L310-L346
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           a s d f j k l ;
          )
          (defvar
           tap-time 250
           hold-time 200
          )
          (defalias
           a (tap-hold $tap-time $hold-time a lmet)
           s (tap-hold $tap-time $hold-time s lalt)
           d (tap-hold $tap-time $hold-time d lctl)
           f (tap-hold $tap-time $hold-time f lsft)
           ; (tap-hold $tap-time $hold-time ; rmet)
           l (tap-hold $tap-time $hold-time l ralt)
           k (tap-hold $tap-time $hold-time k rctl)
           j (tap-hold $tap-time $hold-time j rsft)
          )
          (deflayer base
           @a @s @d @f @j @k @l @;
          )
        '';
      };
    };
  };
}
