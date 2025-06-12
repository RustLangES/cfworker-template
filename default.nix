{
  pkgs,
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  crane,
  fenix,
  wrangler-fix,
  ...
}: let
  # fenix: rustup replacement for reproducible builds
  toolchain = fenix.fromToolchainFile {
    file = ./rust-toolchain.toml;
    sha256 = "sha256-KUm16pHj+cRedf8vxs/Hd2YWxpOrWZ7UOrwhILdSJBU=";
  };
  # crane: cargo and artifacts manager
  craneLib = crane.overrideToolchain toolchain;

  nativeBuildInputs = with pkgs; [
    worker-build
    wasm-pack
    wasm-bindgen-cli
    binaryen
  ];

  buildInputs = with pkgs;
    [
      openssl
      pkg-config
      autoPatchelfHook
    ]
    ++ lib.optionals stdenv.buildPlatform.isDarwin [
      pkgs.libiconv
    ];

  worker = craneLib.buildPackage {
    doCheck = false;
    src = craneLib.cleanCargoSource (craneLib.path ./.);
    buildPhaseCargoCommand = "HOME=$(mktemp -d fake-homeXXXX) worker-build --release --mode no-install";

    # Custom build command is provided, so this should be enabled
    doNotPostBuildInstallCargoBinaries = true;

    installPhaseCommand = ''
      cp -r ./build $out
    '';

    nativeBuildInputs = with pkgs; [esbuild] ++ nativeBuildInputs;

    inherit buildInputs;
  };
in {
  # `nix build`
  packages.default = worker;

  # `nix develop`
  devShells.default = craneLib.devShell {
    packages =
      nativeBuildInputs
      ++ buildInputs
      ++ [wrangler-fix.wrangler];
  };
}
