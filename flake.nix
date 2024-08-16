{
  description = "Nix packages for Carbon Capture & Storage utilities";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;

          packages = rec {
            hypre = pkgs.callPackage ./pkgs/hypre.nix { };
            ptscotch = pkgs.callPackage ./pkgs/ptscotch.nix { };
            fblaslapack = pkgs.callPackage ./pkgs/fblaslapack.nix {};
            sowing = pkgs.callPackage ./pkgs/sowing.nix { };
            petsc = pkgs.callPackage ./pkgs/petsc.nix { inherit sowing ptscotch fblaslapack hypre; };
            pflotran-ogs = pkgs.callPackage ./pkgs/pflotran-ogs.nix { inherit petsc; };

            hdf5-fortran = pkgs.hdf5-fortran;
          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
