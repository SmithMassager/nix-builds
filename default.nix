# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs rec { 
    config = {};
    overlays = []; 
  };
  # The (x // y) operator will merge x and y together (if values are present in
  # both x and y then y takes precedence).
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages =  { 
    gmp = callPackage ./gmp.nix { };
    flint = callPackage ./flint.nix { };
    maple = callPackage ./maple.nix { };
    hnfproj = callPackage ./hnfproj.nix { };
  };
in packages
