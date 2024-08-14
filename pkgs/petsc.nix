{ lib, stdenv, fetchFromGitHub, python3, gfortran, mpi, openssh, blas, lapack, sowing }:

stdenv.mkDerivation rec {
  name = "petsc";
  version = "3.20.6";

  src = fetchFromGitHub {
    owner = "petsc";
    repo = "petsc";
    rev = "v${version}";
    hash = "sha256-NLSCbsvQNVNZhEGW6FHkNKq6hO+Zpuk2Bv5y0sASAGY=";
  };

  mpiSupport = true;

  nativeBuildInputs = [ python3 gfortran mpi openssh ];
  buildInputs = [ blas lapack sowing ];

  preConfigure = ''
    patchShebangs ./lib/petsc/bin
    configureFlagsArray=(
      $configureFlagsArray
      "--with-mpi=0"
      "--CC=mpicc"
      "--with-cxx=mpicxx"
      "--with-fc=mpif90"
      "--with-mpi=1"
      "--with-blas=1"
      "--with-lapack=1"
      "--with-scalar-type=real"
      "--with-precision=double"
      "--with-debugging=0"
      COPTFLAGS='-g -O3'
      FOPTFLAGS='-g -O3'
      CXXOPTFLAGS='-g -O3'
    )
  '';

  configureFlags = [ "--CFLAGS=-O3" "--CXXFLAGS=-O3" "--FFLAGS=-O3" ];
}
