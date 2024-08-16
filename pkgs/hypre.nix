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
  version = "2.29.0";

  src = fetchFromGitHub {
    owner = "hypre-space";
    repo = "hypre";
    rev = "v${version}";
    hash = "sha256-wZwo52TvSE/jfi32nXCNTQu/E2tyvaj/dXpA4mBvwDQ=";
  };

  nativeBuildInputs = [
    gfortran
    cmake
  ];

  buildInputs = [ mpi ];

  cmakeDir = "../src";
}
