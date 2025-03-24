# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.timeout = 10;

  hardware.graphics = {
    enable = true;
  };

  # Required for ddcutil
  hardware.i2c.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # networking.networkmanager.dhcp = "dhcpcd";
  networking.firewall.enable = false;

  networking.extraHosts = 
  ''
    66.135.9.229 vultr
    162.55.41.52 hetzner
    192.168.10.12 gitlab.freymedical.corp
  '';

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.variables = {
    OPENSSL_DIR = pkgs.openssl.dev;
  };

  # Required for trash in Nemo
  services.gvfs.enable = true;

  # Enable automatic login for the user.
  services.getty.autologinUser = "user";

  # systemd.services.minidlna.serviceConfig.User = "user";
  # services.minidlna = {
  #   enable = true;
  #   settings = {
  #     port = 8200;
  #     # user = "user";
  #     # group = "user";
  #     # db_dir = "/home/user/.cache/minidlna";
  #     media_dir = [ "/mnt/win/Users/user/Downloads/Shared" ];
  #     friendly_name = "NixOS miniDLNA";
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.xserver = {
    # TODO doesn't work
    deviceSection = ''Option "TearFree" "true"'';
    enable = true;
    windowManager.bspwm.enable = true;
    xkb = {
      # TODO doesn't work
      options = "terminate:ctrl_alt_bksp";
      # Configure keymap in X11
      layout = "pl";
      variant = "";
    };
  };

  services.libinput.mouse.accelProfile = "flat";
  services.libinput.mouse.accelSpeed = "2";

  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
#  services.displayManager.defaultSession = "none+bspwm";
#  services.displayManager.autoLogin.enable = true;
#  services.displayManager.autoLogin.user = "user";

  # sudo without password
  security.sudo.extraConfig = "user ALL=(ALL) NOPASSWD: ALL";

  # auth agent
  security.polkit.enable = true;

  services.pipewire.pulse.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts = {
    packages = with pkgs; [
      dina-font
      nerdfonts
    ];
    fontconfig = {
      defaultFonts = {
        #serif = [ "Liberation Serif" ];
        sansSerif = [ "Liberation Sans" "FreeSans" "Ubuntu" "Vazirmatn" ];
        #monospace = [ "Ubuntu Mono" ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    polybar
    rofi
    sxhkd
    alacritty
    vivid
    lsd
    firefox
    nemo
    qogir-theme
    papirus-icon-theme
    font-manager
    nitrogen
    (python3.withPackages(pypkgs: with pypkgs; [
      dbus-python # polybar-now-playing
      subliminal
    ]))
    ddcutil
    mpv
    brave
    picom-pijulius
    helix
    fzf
    fd
    ripgrep
    git
    lazygit
    fre
    bat
    htop
    numix-cursor-theme
    lxappearance
    wmctrl
    duf
    cava
    killall
    qbittorrent
    pulseaudio
    polybar-pulseaudio-control
    playerctl
    openvpn
    android-tools
    nodejs_22
    pnpm
    # rustup
    unstable.rustc
    unstable.cargo
    unstable.cargo-update
    unstable.cargo-edit
    unstable.cargo-outdated
    unstable.rustfmt
    unstable.clippy
    unstable.rust-analyzer
    # gcc
    # openssl.dev
    unzip
    dconf
    delta
    xclip
    wineWowPackages.stable
    maim
    feh
    ranger
    kdePackages.qt6ct
    # kdePackages.breeze-icons
    kdePackages.kolourpaint
    unstable.surrealdb
    unstable.surrealist
    nvd
    complete-alias
    kdePackages.kdeconnect-kde
    unityhub
    vscode
    mono
    dotnetCorePackages.dotnet_10.sdk
    obs-studio
    ffmpeg
    discord
    redshift
    unstable.helix
    unstable.zed-editor
    usbimager
    nomacs
    gparted
    polkit
  ];
}
