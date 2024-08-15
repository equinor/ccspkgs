{ lib, stdenv, fetchFromGitHub, mpi, gfortran }:

stdenv.mkDerivation rec {
  name = "hypre";
  version = "2.29.0";

  src = fetchFromGitHub {
    owner = "hypre-space";
    repo = "hypre";
    rev = "v${version}";
    hash = "sha256-wZwo52TvSE/jfi32nXCNTQu/E2tyvaj/dXpA4mBvwDQ=";
  };

  nativeBuildInputs = [ gfortran ];

  buildInputs = [ mpi ];

  configurePhase = ''
    pushd src
    ./configure --with-blas=no --with-lapack=no --host=x86_64-linux-gnu
    popd
  '';

  AR = "ar -rcu";
  makeFlags = [ "-C" "src" ];
}
