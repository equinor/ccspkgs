{
  lib,
  stdenv,
  gfortran,
  petsc,
  fetchFromBitbucket,
  mpi,
  python3,
  hdf5-fortran,
}:

stdenv.mkDerivation {
  name = "pflotran-ogs";
  version = "1.8.11";

  src = fetchFromBitbucket {
    owner = "opengosim";
    repo = "pflotran_ogs_1.8";
    rev = "sv11";
    hash = "sha256-/nKK9CsT9mB2Zhk1rKvuCRkR9KUhC+ahUAclRjvU8Uo=";
  };

  nativeBuildInputs = [
    gfortran
    mpi
  ];

  buildInputs = [ petsc ];

  PETSC_DIR = "${petsc}";

  makeFlags = [
    "UPDATE_PROVENANCE=0"
    "FFLAGS=-I${hdf5-fortran.dev}/include"
    "EXTRA_LINK_FLAGS=-L${hdf5-fortran}/lib -lhdf5-fortran"
  ];

  passthru = {
    inherit petsc;
  };
}
