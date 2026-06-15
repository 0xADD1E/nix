{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        Compression = true;
      };
      "fluttershy" = {
        RequestTTY = "force";
        User = "kaja";
      };
      "pinkiepie.stripedsocks.dev" = {
        User = "root";
        Port = 18;
      };
      "pinkiepie.server.0xadd1e.me" = {
        # hostname = "pinkiepie.stripedsocks.dev";
        User = "root";
        Port = 18;
      };
      "*.server.alchemyprime.uk" = {
        ProxyJump = "bastion.infra.alchemyprime.uk";
      };
      "bastion.infra.alchemyprime.uk" = {
        HostName = "100.122.44.13";
        Port = 18;
        User = "ec2-user";
      };
      "*.server.prompt.network" = {
        Port = 18;
        User = "root";
      };
      "kube*.gblba01.infra.xoala.com" = {
        User = "kl";
      };
    };
  };
}
