{ pkgs ? import <nixpkgs> {}, mapleDir ? null }:
let
  gmp = pkgs.callPackage ./gmp.nix { };
  flint = pkgs.callPackage ./flint.nix { };
  openblas = pkgs.callPackage ./openblas.nix { };
in
pkgs.mkShell {
  packages = [
    gmp
    flint
    openblas
    pkgs.clang
  ];

  shellHook = ''
    CSRC="SmithMassagerC"
    MAPLESRC="SmithMassagerMaple"
    rm -rf $CSRC
    rm -rf $MAPLESRC
    git clone https://github.com/SmithMassager/SmithMassagerC.git $CSRC
    git clone https://github.com/SmithMassager/SmithMassagerMaple.git $MAPLESRC
    cd SmithMassagerC
    FILE="defs.mk"
    MAPLE="/Library/Frameworks/Maple.framework/Versions/Current/"
    PWD="$(pwd)/"

    ${
      if mapleDir != null then
        ''
        MAPLE = "${mapleDir}"
        sed -i.bak "s|^\(export INSTALL_DIR := \).*|\1../$MAPLESRC|" "$FILE"
        sed -i.bak "s|^\(export MAPLEDIR := \).*|\1$MAPLE|" "$FILE"
        ''
      else
        ''
        sed -i.bak "s|^\(export INSTALL_DIR := \).*|\1./install|" "$FILE"
        sed -i.bak "/MAPLEDIR\|MAPLEBIN/d" "$FILE"
        sed -i.bak '/^export MAPLEDIR := /d' "$FILE"
        ''
    }

    sed -i.bak "s|^\(export LDLIBS := \).*|\1-lopenblas -lgmp -lm -lflint|" "$FILE"
    sed -i.bak "s|^\(export CC := \).*|\1clang|" "$FILE"
    sed -i.bak "s|^\(export BASEDIR := \).*|\1$PWD|" "$FILE"
    sed -i.bak "s|^\(export OPENBLAS := \).*|\1${openblas}|" "$FILE"
    sed -i.bak "s|^\(export GMP := \).*|\1${gmp}|" "$FILE"
    sed -i.bak "s|^\(export FLINT := \).*|\1${flint}|" "$FILE"

    cd ..
    echo "-------Environment ready. You can now run: cd SmithMassagerC && make && make install-------"
  '';
}
