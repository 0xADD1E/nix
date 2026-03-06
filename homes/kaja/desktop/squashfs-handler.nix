{ pkgs, ... }: {
  home.packages = [ pkgs.squashfsTools ];
  home.file = {
    ".local/share/kio/servicemenus/squashfs-mount.desktop".text = ''
      [Desktop Entry]
      Type=Service
      X-KDE-ServiceTypes=KonqPopupMenu/Plugin
      Icon=media-mount
      MimeType=application/vnd.squashfs;application/octet-stream;
      Actions=mount;unmount;


      [Desktop Action mount]
      Name=Mount SquashFS
      Icon=media-mount
      Exec=(f=%f; mnt_file="$(basename "$f")" && mnt_dir="/tmp/''${mnt_file}-$(echo -n "$f" | sha256sum | head -c 8)" && mkdir -p "$mnt_dir" && (${pkgs.squashfuse}/bin/squashfuse "$f" "$mnt_dir" && xdg-open "$mnt_dir") || kdialog --error "Cannot mount, you can try to mount it manually:\n\nsquashfuse \\"$f\\" \\""$mnt_dir"\\"")

      [Desktop Action unmount]
      Name=Unmount SquashFS
      Icon=media-eject
      Exec=(f=%f; mnt_file="$(basename "$f")" && mnt_dir="/tmp/''${mnt_file}-$(echo -n "$f" | sha256sum | head -c 8)" && (fusermount -u "$mnt_dir" && rm -r "$mnt_dir") || kdialog --error "Cannot unmount, you can try to unmount it manually:\n\nfusermount -u \\""$mnt_dir"\\"")
    '';
    ".local/share/kio/servicemenus/compress-to-squashfs.desktop".text = ''
      [Desktop Entry]
      Type=Service
      X-KDE-ServiceTypes=KonqPopupMenu/Plugin
      X-KDE-Submenu=Compress to SquashFS: zstd
      Icon=application-x-compress
      MimeType=inode/directory;
      Actions=sfs-zstd-01;sfs-zstd-02;sfs-zstd-03;sfs-zstd-04;sfs-zstd-05;sfs-zstd-06;sfs-zstd-07;sfs-zstd-08;sfs-zstd-09;sfs-zstd-10;sfs-zstd-11;sfs-zstd-12;sfs-zstd-13;sfs-zstd-14;sfs-zstd-15;sfs-zstd-16;sfs-zstd-17;sfs-zstd-18;sfs-zstd-19;sfs-zstd-20;sfs-zstd-21;sfs-zstd-22;


      [Desktop Action sfs-zstd-01]
      Name=1
      Exec=lvl=1; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-02]
      Name=2
      Exec=lvl=2; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-03]
      Name=3
      Exec=lvl=3; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-04]
      Name=4
      Exec=lvl=4; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-05]
      Name=5
      Exec=lvl=5; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-06]
      Name=6
      Exec=lvl=6; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-07]
      Name=7
      Exec=lvl=7; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-08]
      Name=8
      Exec=lvl=8; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-09]
      Name=9
      Exec=lvl=9; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-10]
      Name=10
      Exec=lvl=10; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-11]
      Name=11
      Exec=lvl=11; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-12]
      Name=12
      Exec=lvl=12; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-13]
      Name=13
      Exec=lvl=13; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-14]
      Name=14
      Exec=lvl=14; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-15]
      Name=15
      Exec=lvl=15; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-16]
      Name=16
      Exec=lvl=16; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-17]
      Name=17
      Exec=lvl=17; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-18]
      Name=18
      Exec=lvl=18; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-19]
      Name=19
      Exec=lvl=19; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-20]
      Name=20
      Exec=lvl=20; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-21]
      Name=21
      Exec=lvl=21; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl

      [Desktop Action sfs-zstd-22]
      Name=22
      Exec=lvl=22; f=%f; ${pkgs.squashfsTools}/bin/mksquashfs "$f" "$f.$(date +'%%Y.%%m.%%d-%%H.%%M.%%S').squashfs" -noappend -b 1M -comp zstd -Xcompression-level $lvl
    '';
  };
}
