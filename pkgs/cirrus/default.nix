{ pkgs }:

let

  hypre = pkgs.callPackage ./hypre.nix { };
  ptscotch = pkgs.callPackage ./ptscotch.nix { };
  fblaslapack = pkgs.callPackage ./fblaslapack.nix { };
  sowing = pkgs.callPackage ./sowing.nix { };
  petsc = pkgs.callPackage ./petsc.nix {
    inherit
      sowing
      ptscotch
      fblaslapack
      hypre
      ;
  };
  pflotran-ogs = pkgs.callPackage ./pflotran-ogs.nix { inherit petsc; };

in
pflotran-ogs
