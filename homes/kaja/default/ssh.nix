{ ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        compression = true;
      };
      "fluttershy" = {
        extraOptions.RequestTTY = "force";
        host = "fluttershy";
        user = "kaja";
      };
      "pinkiepie.stripedsocks.dev" = {
        user = "root";
        port = 18;
      };
      "pinkiepie.server.0xadd1e.me" = {
        # hostname = "pinkiepie.stripedsocks.dev";
        user = "root";
        port = 18;
      };
      "*.server.alchemyprime.uk" = {
        proxyJump = "bastion.infra.alchemyprime.uk";
      };
      "bastion.infra.alchemyprime.uk" = {
        hostname = "100.122.44.13";
        port = 18;
        user = "ec2-user";
      };
      "*.server.prompt.network" = {
        port = 18;
        user = "root";
      };
      "kube*.gblba01.infra.xoala.com" = {
        user = "kl";
      };
    };
  };
}
