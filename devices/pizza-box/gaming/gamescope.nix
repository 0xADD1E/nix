{ config, lib, pkgs, inputs, ... }:
{
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;

  programs.steam.gamescopeSession.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  services.getty.autologinUser = "user";
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "user";
      command =
        let
          script = pkgs.writeScriptBin "gamescope-mangohud" ''
                    #!${lib.getExe pkgs.bash}
            	set -euxo pipefail
            	export PATH=${pkgs.mangohud}/bin:$PATH
            	gamescopeArgs=(
            	  --adaptive-sync
            	  --hdr-enabled
            	  --mangoapp
            	  --rt
            	  --steam
            	)
            	steamArgs=(
            	  -pipewire-dmabuf
            	  -tenfoot
            	)
            	mangoConfig=(
            	  cpu_temp
            	  gpu_temp
            	  ram
            	  vram
            	)
            	mangoVars=(
            	  MANGOHUD=1
            	  MANGOHUD_CONFIG="$(IFS=,; echo "''${mangoConfig[*]})")"
            	)
            	export "''${mangoVars[@]}"
            	exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"
          '';
        in
        "${lib.getExe script}";
    };
  };
}
