{ config, lib, pkgs, home-manager, ... }:

{

  imports = [
  ];

  users.users.andrewkoro105 = {
    isNormalUser = true;
    hashedPasswordFile = "/etc/nixos/users_conf/andrewkoro105/passhash";
    extraGroups = [ "wheel" "nixconfiers" ];

    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [
      ./ssh_keys/pub/login/base-pc.pub
      #"./users_conf/andrewkoro105/ssh_keys/pub/login/base-pc.pub"
      #"/etc/nixos/users_conf/andrewkoro105/ssh_keys/pub/login/base-pc.pub"
    ];

    packages = with pkgs; [
    ];
  };

  home-manager = {
    users.andrewkoro105 = {
      home.username = "andrewkoro105";
      home.homeDirectory = "/home/andrewkoro105";
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

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          ll = "ls -l";
          la = "ls -la";
          update = "/etc/nixos/scripts/update.sh";
          update-t = "/etc/nixos/scripts/update-t.sh";
          update-f = "/etc/nixos/scripts/update-f.sh";
        };
        history.size = 10000;

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
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
