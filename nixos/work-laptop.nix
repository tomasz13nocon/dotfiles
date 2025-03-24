{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  networking.hostName = "nixos-work-laptop";

  environment.systemPackages = with pkgs; [
    # ...
  ];
}
