{
  autoconf,
  automake,
  bear,
  fetchFromGitHub,
  gmp,
  libtool,
  mpfr,
  stdenv,
  openblas,
}:
stdenv.mkDerivation {
  pname = "flint";
  version = "v3.2.2";

  src = fetchFromGitHub {
    owner = "flintlib";
    repo = "flint";
    rev = "v3.2.2";
    sha256 = "06lqaz335c3jmgr21zy0lssckn0pwfn2708pjlb44zyhqjz0a17y";
  };
  buildInputs = [ 
    autoconf
    automake
    bear
    gmp
    libtool
    mpfr
    openblas
  ];
  configurePhase = ''
    ./bootstrap.sh
    ./configure --prefix=$out --with-blas
  '';
  buildPhase = ''
    bear -- make -j
  '';
  installPhase = ''
    make install
    cp compile_commands.json $out
    echo "!!!!!!HELLO!!!!!"
    echo ${openblas}
  '';
}
