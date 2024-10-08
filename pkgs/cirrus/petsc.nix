{
  lib,
  stdenv,
  blas,
  fetchFromGitHub,
  gfortran,
  lapack,
  hdf5,
  hdf5-fortran,
  mpi,
  openssh,
  python3,
  sowing,
  ptscotch,
  fblaslapack,
  hypre,
}:

stdenv.mkDerivation rec {
  name = "petsc";
  version = "3.19.1";

  src = fetchFromGitHub {
    owner = "petsc";
    repo = "petsc";
    rev = "v${version}";
    hash = "sha256-23U4aSnYuX5Q60StTv0RjWzYhSDUj96N0mDHh2ASeFY=";
  };

  mpiSupport = true;

  nativeBuildInputs = [
    gfortran
    mpi
    openssh
    python3
  ];

  buildInputs = [
    blas
    lapack
    sowing
    ptscotch
    fblaslapack
    hypre
  ];

  preConfigure = ''
    patchShebangs ./lib/petsc/bin
    configureFlagsArray=(
      $configureFlagsArray
      "--CC=mpicc"
      "--with-blas=1"
      "--with-cxx=mpicxx"
      "--with-debugging=0"
      "--with-fblaslapack=1"
      "--with-fc=mpif90"
      "--with-hypre=1"
      "--with-lapack=1"
      "--with-mpi=1"
      "--with-precision=double"
      "--with-ptscotch=1"
      "--with-scalar-type=real"
      COPTFLAGS='-g -O3'
      FOPTFLAGS='-g -O3'
      CXXOPTFLAGS='-g -O3'
    )
  '';

  configureFlags = [
    "--CFLAGS=-O3"
    "--CXXFLAGS=-O3"
    "--FFLAGS=-O3"
  ];
}
