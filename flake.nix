{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flakes
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";

    # Hyperland / Wayland related flakes
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprlock.url = "github:hyprwm/hyprlock";

    # Catppuccin theming
    nix-colors.url = "github:misterio77/nix-colors";
    catppuccin.url = "github:catppuccin/nix";

    # WSL2 flake
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # Custom Flakes
    nixvim.url = "github:dc-tec/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      impermanence,
      hyprland,
      hyprpaper,
      hyprlock,
      nixvim,
      nur,
      nix-colors,
      catppuccin,
      sops-nix,
      nixos-wsl,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];

      wslModules = [
        home-manager.nixosModule
        catppuccin.nixosModules.catppuccin
        impermanence.nixosModule # Needed to disable certain options
        nixos-wsl.nixosModules.default

        ./modules/wsl
        ./modules/core/home-manager
        ./modules/core/nix
        ./modules/core/utils
        ./modules/core/shells
        ./modules/core/system
        ./modules/core/storage # Needed to disable certain options
        ./modules/development
      ];

      sharedModules = [
        nur.modules.nixos.default
        sops-nix.nixosModules.sops
        impermanence.nixosModule
        home-manager.nixosModule
        catppuccin.nixosModules.catppuccin
        nixos-wsl.nixosModules.default

        ./modules
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            NIX_CONFIG = "experimental-features = nix-command flakes";
            nativeBuildInputs = [
              pkgs.nix
              pkgs.home-manager
              pkgs.git
              pkgs.age
              pkgs.age-to-ssh
              pkgs.sops
            ];
          };
        }
      );

      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.nixpkgs-fmt
      );

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        thinkpad-nix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = wslModules ++ [ ./hosts/thinkpad-nix/default.nix ];
        };
        cougar-hyperv = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = sharedModules ++ [ ./hosts/cougar-hyperv/default.nix ];
        };
        cougar-nix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = wslModules ++ [ ./hosts/cougar-nix/default.nix ];
        };
      };
    };
}
