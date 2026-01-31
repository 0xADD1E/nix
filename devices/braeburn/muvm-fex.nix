{lib, pkgs, unstablePkgs, x86Pkgs, inputs, ... }:
let 
  #    ln -s ${lib.getExe x86Pkgs.steam-run-free} /run/steam-run-free
  initScript = pkgs.writeShellScript "muvm-steam-init.sh" ''
    ln -snf ${x86Pkgs.mesa} /run/opengl-driver
    ln -snf ${x86Pkgs.pkgsi686Linux.mesa} /run/opengl-driver-32
    echo 1 > /proc/sys/kernel/print-fatal-signals
    echo enable-shm=no > /run/pulse.conf
    #echo "Run steam with:"
    #echo "  PULSE_CLIENTCONFIG=/run/pulse.conf /run/steam-run-free /path/to/steam"
    #echo
  '';
  mu-run = pkgs.writeShellApplication{
  name="mu-run";
  text=''
    ${lib.getExe unstablePkgs.muvm} -x ${initScript} "$@"
  '';
}; in
{
  virtualisation.waydroid.enable=true;
  virtualisation.libvirtd.enable=true;
  programs.virt-manager.enable=true;
  environment.systemPackages = [ unstablePkgs.muvm mu-run x86Pkgs.mesa-demos ];
}
