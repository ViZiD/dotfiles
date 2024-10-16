{
  lib,
  rustPlatform,
  fetchFromGitHub,
  fetchpatch,
  pkg-config,
  pcsclite,
}:

rustPlatform.buildRustPackage {
  pname = "age-plugin-openpgp-card";
  version = "unstable-2024-04-19";

  src = fetchFromGitHub {
    owner = "wiktor-k";
    repo = "age-plugin-openpgp-card";
    rev = "2551a04f1bceecc3fac900ebb41878fb73e0414b";
    hash = "sha256-WKnwSq4fTqFeXyI8/ysM0U34cN8MK2C9uBYtciw0q1I=";
  };

  cargoPatches = [
    (fetchpatch {
      name = "kdf_fix.patch";
      url = "https://patch-diff.githubusercontent.com/raw/wiktor-k/age-plugin-openpgp-card/pull/4.patch";
      hash = "sha256-CbILvjq3D+euKLtz+Ct6XwVEQra/fUUCFF83f53PlH0=";
    })
  ];

  cargoHash = "sha256-EL0W8UrcZd7TNwNOXxzGZZQg23DIt6Tzg+hhLEpU3Uo=";

  buildInputs = [ pcsclite.dev ];

  nativeBuildInputs = [
    pkg-config
  ];

  meta = {
    description = "Age plugin for using ed25519 on OpenPGP Card devices (Yubikeys, Nitrokeys";
    homepage = "https://github.com/wiktor-k/age-plugin-openpgp-card";
    license = with lib.licenses; [
      asl20
      mit
    ];
    maintainers = with lib.maintainers; [ vizid ];
    mainProgram = "age-plugin-openpgp-card";
  };
}
