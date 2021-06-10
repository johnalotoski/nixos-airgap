{ nixpkgs ? import ./nix {}, system ? "x86_64-linux" }:
let
  config = { pkgs, ... }:
  with pkgs; {
    imports = [ "${nixpkgs.path}/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma5.nix" ];
    nixpkgs.overlays = [ (import ./overlay.nix) ];

    boot.kernelPackages = linuxPackages_latest;

    services.pcscd.enable = true;
    services.udev.packages = [ yubikey-personalization ];

    environment.systemPackages = [
      bech32
      cardano-address
      cardano-cli
      gnupg
      jq
      paperkey
      pinentry-curses
      pinentry-qt
      token-metadata-creator
      wget
      xxd
    ];

    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  evalNixos = configuration: import "${nixpkgs.path}/nixos" {
    inherit system configuration;
  };

in {
  iso = (evalNixos config).config.system.build.isoImage;
}
