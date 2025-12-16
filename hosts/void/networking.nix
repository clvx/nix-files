{config, lib, pkgs, ...}:
{
  networking = {
    hostName = "void";
    # adding hosts to /etc/hosts
    extraHosts =
    ''
      127.0.0.1 binarycache.bitclvx.com
      127.0.0.1 nc.bitclvx.com
    '';
    firewall = {
      interfaces = {
        incusbr0 = {
          allowedTCPPorts = [ 53 67 ];
          allowedUDPPorts = [ 53 67 ];
        };
      };
      allowedTCPPorts = [ 
        # 11434  #ollama
        # 6443 #k3s
        # 80 #nginx hosting nixos binary cache
        # 443 #nginx
        53317 #localsend
      ];
    };
    nameservers = [ 
      #"10.100.100.10"
    ];
  };
}
