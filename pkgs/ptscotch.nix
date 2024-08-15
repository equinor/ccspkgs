{ lib, stdenv, cmake, gfortran, bison, flex, mpi }:

stdenv.mkDerivation rec {
  name = "ptscotch";
  version = "7.0.3";

  nativeBuildInputs = [ cmake gfortran bison flex mpi ];

  src = fetchTarball {
    url = "http://gitlab.inria.fr/scotch/scotch/-/archive/v${version}/scotch-v${version}.tar.gz";
    sha256 = "0krs485gsf6vlhgkh2w96mspbmysmsalj4cnnjp9xk63w39qgcy2";
  };
}
