{
  imports = [
    ./fs.nix
    ./power.nix
    ./boot.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
}
