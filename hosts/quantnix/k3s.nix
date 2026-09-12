{ ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=0640"
      "--write-kubeconfig-group=k3s"
    ];
  };

  users.groups.k3s.members = [ "quantick" ];
}
