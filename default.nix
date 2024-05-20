{
  system,
  pkgs,
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  crane,
  fenix,
  flake-utils,
  ...
}: let
  # fenix: rustup replacement for reproducible builds
  toolchain = fenix.${system}.fromToolchainFile {
    file = ./rust-toolchain.toml;
    sha256 = "sha256-opUgs6ckUQCyDxcB9Wy51pqhd0MPGHUVbwRKKPGiwZU=";
  };
  # crane: cargo and artifacts manager
  craneLib = crane.${system}.overrideToolchain toolchain;

  nativeBuildInputs = with pkgs; [
    worker-build
    wasm-pack
    wasm-bindgen-cli
    binaryen
  ];

  buildInputs = with pkgs; [
    openssl
    pkg-config
    autoPatchelfHook
  ]
  ++ lib.optionals stdenv.buildPlatform.isDarwin [
    pkgs.libiconv
  ];
  # ++ lib.optionals stdenv.buildPlatform.isLinux [
  #   pkgs.libxkbcommon.dev
  # ];

  worker = craneLib.buildPackage {
    doCheck = false;
    src = craneLib.cleanCargoSource (craneLib.path ./.);
    buildPhaseCargoCommand = "HOME=$(mktemp -d fake-homeXXXX) worker-build --release --mode no-install";

    installPhaseCommand = ''
      cp -r ./build $out
    '';

    nativeBuildInputs = with pkgs; nativeBuildInputs ++ [
      esbuild
    ];

    inherit buildInputs;
  };
in
{
  # `nix build`
  packages.default = worker;

  # `nix develop`
  devShells.default = craneLib.devShell {
    buildInputs = nativeBuildInputs ++ buildInputs;
    # pkgs.nodePackages.wrangler
  };
}
