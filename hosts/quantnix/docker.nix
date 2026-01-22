{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_25;
  virtualisation.docker.daemon.settings = {
    ipv6 = false;
  };
}
