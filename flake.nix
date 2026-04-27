{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server"; 
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      vscode-server,
      ...
    }:
    {
      nixosConfigurations.nixpie4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit home-manager; 
          inherit vscode-server; 
        };
        modules = [
          vscode-server.nixosModules.default
          ./configuration.nix
          ./hardware-configuration.nix
          ./users_conf/andrewkoro105/conf.nix
          ./users_conf/root/conf.nix
          ./users_conf/hypoxie/conf.nix
          ./users_conf/Georgii/conf.nix
        ];
      };
    };
}
