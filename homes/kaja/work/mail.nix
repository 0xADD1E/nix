{ ... }: {
  services.davmail = {
    enable = true;
    settings = {
      "davmail.mode" = "O365Modern";
      "davmail.disableGuiNotifications" = false;
      "davmail.showStartupBanner" = true;
    };
  };
}
