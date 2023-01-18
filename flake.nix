{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {self, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      # https://search.nixos.org/ <-- mencari packages apa saja yang
      # tersedia di nix;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        jun = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ({pkgs, ...}:{
              home.stateVersion = "22.05";
              home.username = "jun";
              home.homeDirectory = "/home/afrianjunior";

              home.packages = with pkgs; [
                git
                neofetch
		nodenv
		yarn
		podman
		podman-compose
		neovim
              ];

	      programs.home-manager.enable = true;
	      	
	      programs.fish.enable = true;
	      programs.fish.shellAliases = {
		docker = "podman";
		docker-compose = "podman-compose";
	      };
            })
          ];
        };
      };
    };
  
}
