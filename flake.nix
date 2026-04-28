{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-minecraft,
      ...
    }:
    {
      nixosConfigurations.nixpie4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit 
            home-manager 
            nix-minecraft
          ; 
        };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./minecraft.nix
          ./users_conf/andrewkoro105/conf.nix
          ./users_conf/root/conf.nix
          ./users_conf/hypoxie/conf.nix
          ./users_conf/Georgii/conf.nix
        ];
      };
    };
}
