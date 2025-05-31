{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "maple";
  version = "v3.2.2";

  src = lib.fileset.toSource {
    root = /opt/maple2023;
    fileset = /opt/maple2023;
  };
  installPhase = ''
    cp -r * $out
  '';
}
