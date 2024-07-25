{
  imports = [
    ./fs.nix
    ./power.nix
    ./boot.nix
    ./mic-fix.nix
    ./vap.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
}
