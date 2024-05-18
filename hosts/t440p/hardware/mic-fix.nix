{ pkgs, ... }:
{
  hardware.firmware = [
    (pkgs.runCommand "jack-retask" { } ''
      install -D ${./hda-jack-retask.fw} $out/lib/firmware/hda-jack-retask.fw
    '')
  ];

  boot.extraModprobeConfig = ''
    options snd-hda-intel patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw
  '';
}
