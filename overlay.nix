let
  sources = import ./nix/sources.nix {};
  addressPkgs = import sources.cardano-addresses { gitrev = sources.cardano-addresses.rev; };
  nodePkgs = import sources.cardano-node { gitrev = sources.cardano-node.rev; };
  offchainPkgs = import sources.offchain-metadata-tools { gitrev = sources.offchain-metadata-tools.rev; };

in self: super: {
  inherit (addressPkgs) cardano-address;
  inherit (nodePkgs) bech32 cardano-cli;
  inherit (offchainPkgs) token-metadata-creator;
}
