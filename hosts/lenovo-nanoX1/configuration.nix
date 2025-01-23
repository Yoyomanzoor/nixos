# Lenovo Slim 7 configuration

{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./default.nix
  ];

  # fingerprinting
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;
  services.fprintd.tod = {
    enable = true;
    driver = pkgs.libfprint-2-tod1-vfs0090;
  };

  security.pam.services = {
    gtklock = { };
    gtklock.fprintAuth = true;
  };
  # security.pam.services.gtklock = {
  #   text = ''
  #     auth sufficient pam_unix.so try_first_pass likeauth nullok
  #     auth sufficient pam_fprintd.so
  #     auth include login
  #   '';
  # };

  # # enable fingerprint scanning for sudo
  # security.pam.services.sudo.text = ''
  #   # Account management.
  #   account required pam_unix.so
  #
  #   # Authentication management.
  #   auth sufficient pam_unix.so   likeauth try_first_pass nullok
  #   auth sufficient pam_fprintd.so
  #   auth required pam_deny.so
  #
  #   # Password management.
  #   password sufficient pam_unix.so nullok sha512
  #
  #   # Session management.
  #   session required pam_env.so conffile=/etc/pam/environment readenv=0
  #   session required pam_unix.so
  # '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
