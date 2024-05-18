{
  imports = [
    ./fs.nix
    ./power.nix
    ./boot.nix
    ./mic-fix.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
}
