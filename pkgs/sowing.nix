{ lib, stdenv, fetchFromBitbucket }:

stdenv.mkDerivation rec {
  name = "sowing";
  version = "v1.1.26-p8";

  src = fetchFromBitbucket {
    owner = "petsc";
    repo = "pkg-sowing";
    rev = version;
    hash = "sha256-oh9OP5T9/9mLCVLhlzmGq5s0R1VbIQRBXbTqSJ2pr48=";
  };
}
