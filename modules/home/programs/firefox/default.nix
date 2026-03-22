{
  pkgs,
  inputs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "tl"
    ];

    ## POLICIES
    policies = import ./policies.nix { inherit inputs; };

    ## Bare profile
    profiles.profile1 = {
      id = 1;
      name = "Profile 1";
    };

    ## Extensive profile
    profiles.extensive = {
      id = 0;
      name = "extensive_profile";
      userChrome = builtins.readFile (inputs.dotfiles + "/firefox/chrome/userChrome.css");
      settings = {
        "browser.startup.page" = 3;
        "places.history.enabled" = false;
        "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
        "privacy.clearSiteData.cookiesAndStorage" = true;
        "privacy.clearSiteData.cache" = true;
        "privacy.clearSiteData.formdata" = true;
        "privacy.clearSiteData.siteSettings" = true;
        "privacy.clearHistory.browsingHistoryAndDownloads" = true;
        "privacy.clearHistory.cookiesAndStorage" = true;
        "privacy.clearHistory.cache" = true;
        "privacy.clearHistory.formdata" = true;
        "privacy.clearHistory.siteSettings" = true;
        # "privacy.window.maxInnerWidth" = 1920;
        # "privacy.window.maxInnerHeight" = 1080;
        # "privacy.resistFingerprinting.block_mozAddonManager" = true;
      };
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@no" ];
        };

        "NixOS Wiki" = {
          urls = [
            {
              template = "https://wiki.nixos.org/w/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nw" ];
        };

        "Home Manager" = {
          urls = [
            {
              template = "https://home-manager-options.extranix.com";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "release";
                  value = "master";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
      };
    };
  };
}
