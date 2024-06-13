{
  description = "NixOS Configuration";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here for a rolling release
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hyprland-hy3 = {
    #   url = "github:outfoxxed/hy3";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./install-packages.nix
        ./xdg-mime.nix
        ./custom-hardware-config.nix # This replaces hardware-configuration.nix
        ./fonts.nix
        # Home manager as a module of nixos
        # So home-manager configurations are deployed with nixos-rebuild switch
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.jay = import ./home.nix;
        }
      ];
    };
  };
}
