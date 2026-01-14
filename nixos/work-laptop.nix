{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./common.nix
    ];

  networking.hostName = "nixos-work-laptop";

  fileSystems = {
    "/mnt/win" = {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
    };
  };

  users.users.user = {
    extraGroups = [ "video" ];
  };

  environment.systemPackages = with unstable; [
    # ...
    brightnessctl
  ];

  hardware.graphics.extraPackages = with unstable; [
    libgbm
    intel-vaapi-driver
    intel-media-driver
  ];

  services.xserver = {
    xkb = {
      options = "caps:swapescape";
    };
  };

  # Allow 'video' group to change backlight brightness (needed for polybar scroll brightness change)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w $sys$devpath/brightness"
  '';

  services.libinput = {
    touchpad.naturalScrolling = true;
    touchpad.accelProfile = "adaptive";
    touchpad.accelSpeed = null;
  };

  swapDevices = [ {
    device = "/swapfile";
    size = 16*1024;
  } ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
