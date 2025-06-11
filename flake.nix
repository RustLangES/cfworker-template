{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrangler = {
      url = "github:ryand56/wrangler";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
  # Iterate over Arm, x86 for MacOs 🍎 and Linux 🐧
    flake-utils.lib.eachSystem (flake-utils.lib.defaultSystems) (
      system:
        import ./. rec {
          inherit system flake-utils;
          pkgs = import nixpkgs { inherit system; };
          crane = inputs.crane.mkLib pkgs;
          fenix = inputs.fenix.packages.${system};
          wrangler-fix = inputs.wrangler.packages.${system};
        }
    );
}
