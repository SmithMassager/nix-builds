{
  autoconf,
  automake,
  fetchFromGitHub,
  libtool,
  mpfr,
  stdenv,
  openblas,
  gmp,
  flint,
  maple,
}:
stdenv.mkDerivation {
  pname = "hnfproj";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "deft-gur";
    repo = "hnfproj";
    rev = "1.2";
    sha256 = "sha256-UILKzvZMK/kfbYKRWnTJoQcfvNjYdyQXln/5fFXRwq0=";
  };
  buildInputs = [ 
    autoconf
    automake
    libtool
    mpfr
    openblas
    flint
    gmp
    maple
  ];
  configurePhase = ''
    FILE="defs.mk"

    sed -i.bak "s|^\(export MAPLEDIR := \).*|\1${maple}|" "$FILE"
    sed -i.bak "s|^\(export OPENBLAS := \).*|\1${openblas}|" "$FILE"
    sed -i.bak "s|^\(export GMP := \).*|\1${gmp}|" "$FILE"
    sed -i.bak "s|^\(export FLINT := \).*|\1${flint}|" "$FILE"
    sed -i.bak "s|^\(export INSTALL_DIR := \).*|\1$out|" "$FILE"
  '';

  buildPhase = ''
    make
  '';
  installPhase = ''
    make install
  '';
}
