{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.benchmark.enable = lib.mkEnableOption "benchmark";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.benchmark.enable {
    environment = {
      systemPackages = with pkgs; [
        hyperfine
        poop
      ];
    };
  };
}
