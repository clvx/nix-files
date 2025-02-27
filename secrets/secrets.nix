let
  void = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILpr0ETS22u/CItYB1NoMEzOYBBW/MuID5My5OadC/9T root@nixos";
  systems = [ void ];
in
{
  "nix-serve.age".publicKeys = systems;
  "gandi-api-key.age".publicKeys = systems;
  "nextcloud-admin-pass.age".publicKeys = systems;
}
