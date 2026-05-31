{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ForwardAgent = true;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 120;
        ControlMaster = "auto";
        ControlPath = "/home/clvx/.ssh/mux-%r@%h:%p";
        ControlPersist = "4h";
      };

      "github.com" = {
        IdentityFile = "~/.ssh/id_vcs_rsa";
        IdentitiesOnly = true;
      };

      "gitlab.com" = {
        IdentityFile = "~/.ssh/id_vcs_rsa";
        IdentitiesOnly = true;
      };
    };
  };
}
