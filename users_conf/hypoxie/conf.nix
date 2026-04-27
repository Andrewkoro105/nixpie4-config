{ config, lib, pkgs, home-manager, ... }:

{

  imports = [
  ];

  users.users.hypoxie = {
    isNormalUser = true;
    hashedPasswordFile = "/etc/nixos/users_conf/hypoxie/passhash";
    extraGroups = [ "wheel" "nixconfiers" ];

    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [
      ./ssh_keys/pub/login/base-pc.pub
    ];

    packages = with pkgs; [
    ];
  };

  home-manager = {
    users.hypoxie = {
      home.username = "hypoxie";
      home.homeDirectory = "/home/hypoxie";
      home.stateVersion = "26.05";

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "hypoxie";
            email = "kosmaer42@gmail.com";
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
            identityFile = "/etc/nixos/users_conf/hypoxie/ssh_keys/private/nixpie4-config";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
