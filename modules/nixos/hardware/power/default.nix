{ ... }:
{
  imports = [ ./tlp.nix ];

  # Power management
  powerManagement = {
    enable = true;
    # Auto tuning on startup
    powertop.enable = true;
  };

  services.upower = {
    enable = true;
    # Policy for warnings and action based on battery levels
    usePercentageForPolicy = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    allowRiskyCriticalPowerAction = true;
    criticalPowerAction = "Hibernate";
  };

  # Prevents overheating on Intel CPUs
  services.thermald.enable = true;
}
