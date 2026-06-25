{ config, lib, ... }:
{
  # Set PulseAudio to false to use PipeWire.
  services.pulseaudio.enable = !config.services.pipewire.enable;

  # Optional but recommended. Allows PipeWire to use
  # realtime scheduler for increased performance.
  security.rtkit.enable = config.services.pipewire.enable;

  services.pipewire = {
    pulse.enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;

    # Enable to use JACK applications
    jack.enable = lib.mkDefault false;
  };
}
