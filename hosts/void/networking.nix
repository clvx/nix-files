{config, lib, pkgs, ...}:
{
  networking = {
    networkmanager.unmanaged = [ "enp6s0" ];
    hostName = "void";
    bridges = {
      br0 = {
        interfaces = [ "enp6s0" ];
      };
    };
    interfaces = {
      br0 = {
        #k3s needs an ipv6 address here
      };
    };
    defaultGateway6 = {
      address = "fe80::16eb:b6ff:fe28:dd94";
      interface = "br0";
    };
    # adding hosts to /etc/hosts
    extraHosts =
    ''
      127.0.0.1 binarycache.bitclvx.com
    '';
    firewall = {
      allowedTCPPorts = [ 
        11434  #ollama
        6443 #k3s
        80 #nginx hosting nixos binary cache
      ];
    };

  };

  #ZFS config
  networking.hostId = "810dc719";
}
