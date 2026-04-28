{ config, lib, pkgs, home-manager, ... }:

{

  imports = [
    home-manager.nixosModules.home-manager
  ];

  nixpkgs.config.allowUnfree = true;

  users.mutableUsers = false;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "nixpie4";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  users.groups.nixconfiers = {};

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 53 ];
    allowedUDPPorts = [ 53 ];
  };
  networking.nftables.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;  

  programs.zsh = {
    enable = true;
    shellInit = ''
      TERM=xterm
    '';
  };

  programs.git = {
    enable = true;
    config = {
      safe.directory = [
        "/etc/nixos"
      ];
    };
  };
 
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    tree
    wget
    btop
    bat
    hostapd
    dnsmasq
    iw
    lsof
  ];
 
  #networking.wireless = {
  #  enable = true;
  #  interfaces = [ "wlan1" ];   # wlan0 не упоминается
  #};

  networking.wireless.enable = lib.mkForce false;

  networking = {
    networkmanager.unmanaged = [ "wlan0" ];   # обязательно
    interfaces.wlan0.ipv4.addresses = [{
      address = "10.10.0.1";
      prefixLength = 24;
    }];
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wlan0" ];
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "wlan0";
      #dhcp-range = "10.10.0.10,10.10.0.100,12h";
      dhcp-range = "192.168.51.50,192.168.51.150,12h";
      dhcp-host="30:f2:3c:13:2b:93,192.168.51.60";
      server = [ "127.0.0.1" "8.8.8.8" "8.8.4.4" ];
    };
  };

  services.hostapd = {
    enable = true;
    radios.wlan0 = {
      band = "2g";
      channel = 6;
      countryCode = "US";
      
      # 🔧 Ключевое исправление: убираем SHORT-GI-40
      wifi4.capabilities = [
        # "HT40+"          # разрешить 40 МГц (опционально, если нужно)
        "SHORT-GI-20"   # короткий интервал для 20 МГц
        # "SHORT-GI-40" — удалён, так как не поддерживается драйвером
        # "DSSS_CCK-40"   # разрешить DSSS/CCK в 40 МГц
      ];

      networks.wlan0 = {
        ssid = "Hotspot";
        authentication = {
          mode = "none"; 
          #mode = "wpa-sha256"
          #wpaPassword = "12345678";
        };
      };
    };
  };


  system.stateVersion = "26.05";
}
