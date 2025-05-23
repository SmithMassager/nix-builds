{
  stdenv,
  fetchzip,
  gnum4,
}:

stdenv.mkDerivation {
  pname = "gmp";
  version = "6.3.0";

  src = fetchzip {
    url = "https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz";
    sha256 = "1kc3dy4jxand0y118yb9715g9xy1fnzqgkwxy02vd57y2fhg2pcw";
  };

  buildInputs = [ gnum4 ];
}
