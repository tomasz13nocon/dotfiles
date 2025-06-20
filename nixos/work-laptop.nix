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

  users.users.user = {
    extraGroups = [ "video" ];
  };

  environment.systemPackages = with pkgs; [
    # ...
    brightnessctl
  ];

  services.xserver = {
    xkb = {
      options = "caps:swapescape";
    };
  };

  services.libinput = {
    touchpad.naturalScrolling = true;
    touchpad.accelProfile = "adaptive";
    touchpad.accelSpeed = null;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
