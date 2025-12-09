final: prev:
let
  overlays = [
    # (import ./modules/azahar.nix)
    (import ./modules/hakuneko-nightly.nix)
  ];
in
prev.lib.composeManyExtensions overlays final prev
