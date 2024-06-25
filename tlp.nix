{ config, lib, pkgs, ... }:

{
  # Enable TLP for reduced battery consumption
  services.tlp = {
    enable = true;
    
  };
}