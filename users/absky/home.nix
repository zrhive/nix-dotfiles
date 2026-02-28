{ pkgs, home, ... }:

{
  # TODO: Import home configs/packages.
  imports = [
    home.programs.default
    home.services.default
    home.themes.default
  ];

  # TODO: Custom configs.
  # programs.firefox.enable = true;
}

/* NOTE: options for packages to import in home manager.
    for custom configs, and/or no available configs,
    see: https://home-manager-options.extranix.com/

  home/programs
  -- default: import default programs
  -- git neovim feh qimgv kitty yazi rofi

  home/services
  -- default: import default services
  -- dunst

  home/themes
  -- default: import default themes
    { fonts = JetBrainsMono; icons = papirus; cursors = bibata; }
  -- icons: papirus paper
  -- cursors:

  USAGE: examples on how to use/import these packages
  home.

  SEE HOME DIRECTORY FOR MORE:
  ```
  .
  └── home/
      ├── programs/
      ├── services/
      └── themes/

  ```
*/
