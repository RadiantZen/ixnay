{ config, lib, ... }:

let
  extension_list = [
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" # Bitwarden
    "addon@darkreader.org"
    "redirector@einaregilsson.com"
    "search@kagi.com"
    "skipredirect@sblask"
    "sponsorBlocker@ajay.app"
    "uBlock0@raymondhill.net"
    "harper@writewithharper.com"
  ];
  extension_attr = lib.attrsets.genAttrs extension_list (i: {
    installation_mode = "force_installed";
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${i}/latest.xpi";
    private_browsing = true;
  });
in
{
  options = {
    ixnay.programs.browser.firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.ixnay.programs.browser.firefox.enable {
    programs = {
      firefox = {
        enable = true;
        wrapperConfig = {
          pipewireSupport = true;
        };
        policies = {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DownloadDirectory = "\${home}/Downloads/firefox";
          DontCheckDefaultBrowser = true;
          ExtensionSettings = extension_attr;
          HttpsOnlyMode = "enabled";
          OfferToSaveLoginsDefault = false;
        };
        preferences = {
          "browser.ml.chat.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "widget.gtk.overlay-scrollbars.enabled" = false;
          "browser.contentblocking.category" = "strict";
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
        };
        preferencesStatus = "user";
      };
    };
  };
}
