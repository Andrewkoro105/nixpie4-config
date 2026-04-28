{ 
  config, 
  lib, 
  pkgs, 
  home-manager, 
  nix-minecraft, 
  ... 
}: {
  imports = [ nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ nix-minecraft.overlay ];
  
  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.random_gay_orgy = {
      enable = true;
      autoStart = true;

      package = pkgs.fabricServers.fabric-1_21_1.override {
        loaderVersion = "0.16.10";
      }; # Specific fabric loader version

      serverProperties = {
        motd = "Мой сервер на NixOS и Raspberry Pi!";
        online-mode = false;
        max-players = 10;
        view-distance = 6;
        simulation-distance = 6;
        difficulty = 4;                 # 1 - мирный, 2 - легкий, 3 - нормальный, 4 - сложный
        gamemode = 1;                   # 0 - выживание, 1 - творческий, 2 - приключение, 3 - наблюдение
      };

      jvmOpts = "-Xms1024M -Xmx4096M"; # Выделяем от 1 до 2 ГБ ОЗУ

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/9YVrKY0Z/fabric-api-0.115.0%2B1.21.1.jar";
              sha512 = "e5f3c3431b96b281300dd118ee523379ff6a774c0e864eab8d159af32e5425c915f8664b1cd576f20275e8baf995e016c5971fea7478c8cb0433a83663f2aea8";
            };
            Backpacks = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
              sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
            };
            Random-Crafts = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/d4RW7cgE/versions/orZ2HzQP/random_crafts-1.2.0-neoforge-1.21.1.jar";
              sha512 = "sha512-RsTUg7/z7kfLAn/8vFAZrr31CH52TGshF15gesCMu0xdpG+H4hCqjkZhVvpqhNH2wuGIPgzUQ3SY8+fGclVdQw==";
            };
          }
        );
      };
    };
  };
}
