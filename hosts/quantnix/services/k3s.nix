# ==========================================================
# k3s — локальный одноузловой Kubernetes
# ==========================================================
{ ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      # kubeconfig читаем для группы k3s → kubectl без sudo
      "--write-kubeconfig-mode=0640"
      "--write-kubeconfig-group=k3s"
    ];
  };

  users.groups.k3s.members = [ "quantick" ];
}
