let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
in
pkgs.mkShell {
  packages = with pkgs; [
    shellcheck
    luajit
    npins
    colmena
    sops
  ];
}
