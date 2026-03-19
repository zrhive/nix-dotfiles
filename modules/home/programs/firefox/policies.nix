{
  ## General
  DontCheckDefaultBrowser = true;
  OfferToSaveLogins = false;
  GenerativeAI.Enabled = false;
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "default-off";
  SanitizeOnShutdown = {
    Cache = true;
    FormData = true;
  };

  ## Firefox
  DisableFirefoxAccounts = true;
  DisableFirefoxStudies = true;
  DisableTelemetry = true;
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredPocket = false;
    SponsoredStories = false;
    Snippets = false;
  };
  UserMessaging = {
    ExtensionRecommendations = false;
    FeatureRecommendations = true;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
    FirefoxLabs = true;
  };

  ## Search
  SearchSuggestEnabled = false;
  SearchEngines = {
    Remove = [
      "Google"
      "Bing"
      "Perplexity"
      "Wikipedia"
    ];
    Add = [
      {
        "Name" = "Startpage";
        "URLTemplate" = "https://www.startpage.com/sp/search?query={searchTerms}";
        "IconURL" = "https://www.startpage.com/favicon.ico";
        "Alias" = "sp";
      }
    ];
  };

  ## Privacy and Security
  PasswordManagerEnabled = false;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };
  HttpsOnlyMode = "forced_enabled";
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = " https://sky.rethinkdns.com/1:AAoACAgA";
    Fallback = true;
  };
  Cookies = {
    Allow = [
      "https://github.com"
      "https://notion.so"
    ];
    AllowSession = [
      "https://proton.me"
      "https://tuta.com"
    ];
  };

  ## Extensions
  "3rdParty" = {
    Extensions = {
      "uBlock0@raymondhill.net".adminSettings = (builtins.readFile ./ublock.txt);
    };
  };
  ExtensionSettings = {
    # ublock origin
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      private_browsing = true;
    };
    # keepassxc
    "keepassxc-browser@keepassxc.org" = {
      installation_mode = "allowed";
      # install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
      private_browsing = true;
    };
    # bitwarden
    # "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
    #   installation_mode = "allowed";
    #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    #   private_browsing = true;
    # };
  };

  ## Preferences
  Preferences = import ./preferences.nix;
}
