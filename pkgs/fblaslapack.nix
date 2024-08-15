{ lib, stdenv, fetchFromBitbucket, gfortran }:

stdenv.mkDerivation rec {
  name = "fblaslapack";
  version = "3.4.2-p3";

  src = fetchFromBitbucket {
    owner = "petsc";
    repo = "pkg-fblaslapack";
    rev = "v${version}";
    hash = "sha256-ExN0ahpMVI+sBYQB+LzWUnyyPGJa6BpaPlEiRM21P60=";
  };

  nativeBuildInputs = [ gfortran ];

  makeFlags = ["FOPTFLAGS=-fallow-argument-mismatch" "RM=rm"];

  installPhase = ''
    for f in libfblas.a libflapack.a; do
      install -D $f $out/lib/$f
    done
  '';
}
