{ sources ? import ./sources.nix }:
let
  # airgapPkgs = import sources.nixpkgs-airgap {};
  # addressPkgs = import sources.cardano-addresses { gitrev = sources.cardano-address.rev; };
  # nodePkgs = import sources.cardano-node { gitrev = sources.cardano-node.rev; };
in with {
  overlay = self: super: {
    # inherit (import sources.niv { }) niv;
    # inherit (addressPkgs) cardano-address;
    # inherit (nodePkgs) bech32 cardano-cli;
  };
};
import sources.nixpkgs-airgap {
  overlays = [ overlay ];
  config = { };
}
