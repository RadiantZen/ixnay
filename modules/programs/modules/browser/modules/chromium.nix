{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.browser.chromium.enable = lib.mkEnableOption "chromium";
  };

  config = lib.mkIf config.ixnay.programs.browser.chromium.enable {
    environment = {
      systemPackages = with pkgs; [ chromium ];
    };
    programs = {
      chromium = {
        enable = true;
        extensions = [
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock lite
          "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
          "nngceckbapebfimnlniiiahkandclblb" # bitwarden
          "lmjnegcaeklhafolokijcfjliaokphfk" # video download helper
        ];
        extraOpts = {
          "BrowserThemeColor" = "";
          "PasswordManagerEnabled" = false;
          "AutofillAddressEnabled" = false;
          "ShowFullUrlsInAddressBar" = true;
          "DefaultNotificationsSetting" = 2;
          # "DefaultDownloadDirectory" = ;
        };
      };
    };
  };
}
