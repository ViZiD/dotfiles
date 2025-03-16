{ stdenv, lib }:

stdenv.mkDerivation rec {
  name = "qca9377_firmware-${version}";
  version = "5";
  src = ./firmware-5.bin;
  sourceRoot = ".";
  dontBuild = true;
  unpackPhase = ''
    cp "$src" .
  '';

  installPhase = ''
    mkdir -p "$out/lib/firmware/ath10k/QCA9377/hw1.0"
    cp "$src" "$out/lib/firmware/ath10k/QCA9377/hw1.0/firmware-5.bin"
    cp "$src" "$out/lib/firmware/ath10k/QCA9377/hw1.0/firmware-6.bin"
  '';

  # Firmware blobs do not need fixing and should not be modified
  dontFixup = true;

  meta = with lib; {
    description = "Binary firmware for QCA9377 chipset";
    homepage = "https://github.com/kvalo/ath10k-firmware";
    license = licenses.unfreeRedistributableFirmware;
    platforms = platforms.linux;
    # priority = 6; # give precedence to kernel firmware
  };

  passthru = { inherit version; };
}
