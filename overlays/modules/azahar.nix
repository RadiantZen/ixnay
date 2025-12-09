let
  sources = import ../../npins;
in

final: prev: {
  azahar = prev.azahar.overrideAttrs (old: {
    src = sources.AzaharPlus;
  });
}
