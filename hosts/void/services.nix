{config, lib, pkgs, pkgs-unstable, ...}:
{
  age = { 
    # Define the secrets to be managed by agenix
    secrets = {
      # For ACME’s Gandi DNS provider credentials
      gandi-api-key = {
        file = ../../secrets/gandi-api-key.age;
        owner = "acme";
      };

      # For Nextcloud’s admin password
      nextcloud-admin-pass = {
        file = ../../secrets/nextcloud-admin-pass.age;
        owner = "nextcloud";
        mode = "0440";
      };
    };
  };

 security = {
   acme = {
     acceptTerms = true;
     email = "michael.ibarra@gmail.com";
     certs = {
       ${config.services.nextcloud.hostName} = {
         dnsProvider = "gandiv5";
         # Let's encrypt credentials MUST follow https://go-acme.github.io/lego/dns/
         credentialsFile = config.age.secrets.gandi-api-key.path;
         #server = "https://acme-staging-v02.api.letsencrypt.org/directory"; #staging server
         group = config.services.nginx.group;
       };
     };
   };
 };


  services = {
    ## enable ZFS auto snapshot on datasets
    ## You need to set the auto snapshot property to "true"
    ## on datasets for this to work, such as
    # zfs set com.sun:auto-snapshot=true rpool/nixos/home
    zfs = {
      autoSnapshot = {
        enable = false; flags = "-k -p --utc";
        monthly = 48;
      };
    };


    #LLM - https://wiki.nixos.org/wiki/Ollama
    ollama = {
      package = pkgs-unstable.ollama;
      enable = false;
    };

    k3s = {
      enable = false;
      role = "server";
      extraFlags = toString[
        #cilium configuration
        # https://docs.k3s.io/networking/networking-services
        "--flannel-backend=none" #cilium cni
        "--disable-network-policy" #cilium network policy
        "--disable=traefik" #cilium ingress
        "--disable=servicelb" #so metallb or l2 announcement can be used
        "--disable-kube-proxy" #using ebpf instead
     ];
    };

    # NixOs binary cache configuration
    #https://nixos.wiki/wiki/Binary_Cache
    nix-serve = {
      enable = false;
      secretKeyFile = /var/cache-priv-key.pem;
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        # ... existing hosts config etc. ...
        #"binarycache.bitclvx.com" = {
        #  locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
        #};
        ${config.services.nextcloud.hostName} = {
          forceSSL = true;
          enableACME = true; #TODO: Write about this option and acmeRoot being null
          acmeRoot = null;

          # The important lines:
          sslCertificate = config.security.acme.certs."${config.services.nextcloud.hostName}".certificate;
          sslCertificateKey = config.security.acme.certs."${config.services.nextcloud.hostName}".key;
        };
      };
    };


    #https://github.com/NixOS/nixpkgs/issues/111175
    nextcloud = {
      enable = true;
      hostName = "nc.bitclvx.com";

       # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud30;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      https = true;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit calendar contacts;
      };

      settings.enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];

      #TODO: this needs to be updated
      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "MT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = config.age.secrets.nextcloud-admin-pass.path;
      };
    };
  };
}
