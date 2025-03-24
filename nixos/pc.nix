{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  networking.hostName = "nixos-pc"; # Define your hostname.

  services.jellyfin = {
    enable = true;
  };

  fileSystems = {
    "/mnt/win" = {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
    };
    "/mnt/hdd" = {
      device = "/dev/sdb1";
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.18. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      # "public" = {
      #   "path" = "/mnt/Shares/Public";
      #   "browseable" = "yes";
      #   "read only" = "no";
      #   "guest ok" = "yes";
      #   "create mask" = "0644";
      #   "directory mask" = "0755";
      #   "force user" = "username";
      #   "force group" = "groupname";
      # };
      "shared" = {
        "path" = "/mnt/shared";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "user";
        "force group" = "user";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    minidlna
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
