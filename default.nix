# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  gmp = pkgs.callPackage ./gmp.nix { };
  flint = pkgs.callPackage ./flint.nix { };
}
