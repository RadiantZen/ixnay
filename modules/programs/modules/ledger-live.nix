{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.ledger-live.enable = lib.mkEnableOption "ledger live";
  };

  config = lib.mkIf config.ixnay.programs.ledger-live.enable {
    environment = {
      systemPackages = with pkgs; [
        ledger-live-desktop
        monero-cli
        monero-gui
      ];
    };
    hardware.ledger.enable = true;
  };
}
