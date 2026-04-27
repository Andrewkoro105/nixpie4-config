{ config, lib, pkgs, home-manager, ... }:

{

  imports = [
  ];

  users.users.Georgii = {
    isNormalUser = true;
    hashedPasswordFile = "/etc/nixos/users_conf/Georgii/passhash";
    extraGroups = [ "wheel" "nixconfiers" ];

    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [
      ./ssh_keys/pub/login/base-pc.pub
    ];

    packages = with pkgs; [
    ];
  };

  home-manager = {
    users.Georgii = {
      home.username = "Georgii";
      home.homeDirectory = "/home/Georgii";
      home.stateVersion = "26.05";

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Georgii";
            email = "Georgii@gmail.com";
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
            identityFile = "/etc/nixos/users_conf/Georgii/ssh_keys/private/nixpie4-config";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
