{
# Laptop packages, for things like power profiles
# See https://nixos.wiki/wiki/Laptop
  imports = [
    ./default.nix
  ];

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
}
