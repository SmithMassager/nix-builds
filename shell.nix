{ pkgs ? import <nixpkgs> {} }:
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
  ];

  shellHook = ''
    git clone https://github.com/deft-gur/hnfproj.git hnfproj
    cd hnfproj
    FILE="defs.mk"
    MAPLE="/Library/Frameworks/Maple.framework/Versions/2025/"

    sed -i.bak "s|^\(export MAPLEDIR := \).*|\1$MAPLE|" "$FILE"
    sed -i.bak "s|^\(export OPENBLAS := \).*|\1${openblas}|" "$FILE"
    sed -i.bak "s|^\(export GMP := \).*|\1${gmp}|" "$FILE"
    sed -i.bak "s|^\(export FLINT := \).*|\1${flint}|" "$FILE"
    sed -i.bak "s|^\(export INSTALL_DIR := \).*|\1$out|" "$FILE"

    make
  '';
}
