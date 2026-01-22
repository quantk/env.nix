{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_25;
  virtualisation.docker.daemon.settings = {
    userland-proxy = false;
    experimental = true;
    ipv6 = false;
  };

}
