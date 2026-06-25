{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.services.printing.extraDrivers = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    description = "Extra drivers to install.";
  };

  config = lib.mkIf config.services.printing.enable {
    # Enable CUPS to print documents.
    services.printing = {
      openFirewall = true;

      drivers = config.services.printing.extraDrivers ++ [
        # Backends, filters, and other software of the core CUPS distribution.
        pkgs.cups-filters

        # Browsing of remote CUPS printers.
        # pkgs.cups-browsed

        # Tools for interacting with CUPS server.
        # pkgs.cups-printers

        # Drivers for many different printers from many different vendors.
        # pkgs.gutenprint
      ];
    };
  };
}
