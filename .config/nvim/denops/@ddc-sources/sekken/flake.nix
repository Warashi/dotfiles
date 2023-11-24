{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    fenix,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        rust-toolchain = with fenix.packages.${system};
          combine [
            complete.toolchain
            targets.wasm32-unknown-unknown.latest.rust-std
          ];
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              binaryen
              cargo-edit
              rust-toolchain
              wasm-pack
              wasm-bindgen-cli
            ];
          };
      }
    );
}
