{
  autoconf,
  automake,
  fetchFromGitHub,
  libtool,
  mpfr,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "openblas";
  version = "v0.3.29";

  src = fetchFromGitHub {
    owner = "OpenMathLib";
    repo = "OpenBLAS";
    rev = "v0.3.29";
    sha256 = "sha256-n/3FGmZxnNiOEKYHSIuqX2LJS1BzYPCwLWT9DSwEoPI=";
  };
  buildInputs = [ 
    autoconf
    automake
    libtool
    mpfr
  ];
  installPhase = ''
    make install PREFIX=$out
  '';
}
