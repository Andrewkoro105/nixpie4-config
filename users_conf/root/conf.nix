{ config, lib, pkgs, home-manager, ... }:

{

  users.users.root.hashedPasswordFile = "/etc/nixos/users_conf/root/passhash";
  #users.users.root.hashedPassword = "$6$/GaKvSWvgDC4ZxYh$kz3UwYCWDIvKBPY1ZmEpRt/0rg0LUeUpfexkGiEotym9AhMmilza1QYhUE/e/d/FY.zHoiWLhfUWSMG2..ZEM/";

  home-manager = {
    users.root = {
      home.username = "root";
      home.homeDirectory = "/root";
      home.stateVersion = "26.05";
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Andrew Korovkin";
            email = "andrewkoro105@gmail.com";
          };
        };
      };
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "yes";
          };        
          "nixpie4-config" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/etc/nixos/users_conf/andrewkoro105/ssh_keys/private/nixpie4-config";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
