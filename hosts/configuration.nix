# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,inputs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
# Automate garbage collection
nix.gc = {
  automatic = true;
  dates = "daily"; # Runs daily to clean up behind the scenes
  options = "--delete-older-than 2d"; # Deletes generations older than 2 days
};
  # Bootloader.
boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd = {
      systemd.enable = true;
      kernelModules = [ "amdgpu" "i915" ];
    };

    plymouth = {
      enable = true;
      theme = "spinner";
    };

    kernelParams = [
      "quiet"
      "splash"
    ];
  };

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

fonts.packages = with pkgs; [
  jetbrains-mono
];


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;



   # 1. Enable SDDM
  services.displayManager.sddm ={
      enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = [pkgs.sddm-astronaut];
    };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
programs.fish.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anand = {
    isNormalUser = true;
    description = "Anand";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    thunderbird
    ];
  };

  users.users.akhil = {
isNormalUser = true;
description = "Akhil";
extraGroups = [ "networkmanager" "wheel"];
shell= pkgs.fish;
packages = with pkgs;[

];
    };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.niri = {
enable = true;

  };
services.keyd = {
  enable = true;
  keyboards = {
    default = {
      ids = [ "*" ]; # Matches all keyboards
      settings = {
        main = {
          # Example: Hold CapsLock for Ctrl, tap for Escape
          capslock = "overload(control, esc)";
          # Example: Remap Escape to CapsLock
          esc = "capslock";
        };
      };
    };
  };
};



  # list packages installed in system profile. to search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # do not forget to add an editor to edit configuration.nix! the nano editor is also installed by default.
  wget
  noctalia-shell
  eza
  yazi
  uv
  bun
  neovim
  google-chrome
  brave
  distrobox
  zed
  gnome-tweaks
  helix
  stow
  starship
  kitty
  alacritty
  cliphist
  wlsunset
  xdg-desktop-portal
  evolution-data-server
  python3
  curl
  wget
  git
  nodejs_24
  fd
  tree
  ruff
  gcc
  sddm-astronaut
  ];

programs.nix-ld.enable = true;
environment.variables = {
  EDITOR = "nvim";
  NIX_BUILD_CORES = "4";
};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
