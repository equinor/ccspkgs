{
  lib,
  stdenv,
  fetchFromGitHub,
  mpi,
  gfortran,
  cmake,
}:

stdenv.mkDerivation rec {
  name = "hypre";
  version = "2.28.0";

  src = fetchFromGitHub {
    owner = "hypre-space";
    repo = "hypre";
    rev = "v${version}";
    hash = "sha256-/k2ijrre1xYT5cYrW4QbH3spgifWErXE7CnQFH01cnI=";
  };

  nativeBuildInputs = [
    gfortran
    cmake
  ];

  buildInputs = [ mpi ];

  cmakeDir = "../src";
}
