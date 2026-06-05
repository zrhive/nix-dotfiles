{
  #: Misc
  flatpak = import ./flatpak.nix;

  #: Networking
  avahi = import ./avahi.nix;
  dnscrypt = import ./dnscrypt.nix;
  ssh = import ./ssh.nix;
}
