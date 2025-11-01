{config,pkgs,myModulesRoot,...}:{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "user";
}