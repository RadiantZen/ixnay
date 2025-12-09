{ config, lib, ... }:

{
  options = {
    ixnay.programs.thunderbird.enable = lib.mkEnableOption "thunderbird";
  };

  config = lib.mkIf config.ixnay.programs.thunderbird.enable {
    programs = {
      thunderbird = {
        enable = true;
        policies = { };
        preferences = {
          "calendar.alarms.playsound" = false;
          "mail.biff.play_sound" = false;
          "mail.chat.play_sound" = false;
          "mail.feed.play_sound" = false;
          "mail.serverDefaultStoreContractID" = "@mozilla.org/msgstore/maildirstore;1"; # Maildir
          "messenger.options.messagesStyle.theme" = "simple";
        };
        preferencesStatus = "user";
      };
    };
  };
}
