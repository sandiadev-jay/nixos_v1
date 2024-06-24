# This started with a copy of the hardware config
# generated by ‘nixos-generate-config’ to avoid overwrite
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4b7bc006-9c2f-4a56-9984-8f515c20a4cf";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-9f8b172d-be8a-4ada-b4f0-6782569e5a2c".device = "/dev/disk/by-uuid/9f8b172d-be8a-4ada-b4f0-6782569e5a2c";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8B40-B0EE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 64*1024;
  }  ];
  
  # Partition swapfile is on (after LUKS decryption)
  boot.resumeDevice = "/dev/disk/by-uuid/4b7bc006-9c2f-4a56-9984-8f515c20a4cf";
  # Resume Offset is offset of swapfile
  boot.kernelParams = [ "resume_offset=32870400" ];

  # This will save you money and maybe your life?
  services.thermald.enable = true;

  # Because I have an SSD
  services.fstrim.enable = lib.mkDefault true;

  # Having kernel security enabled prevents hibernation
  security.protectKernelImage = false;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  # Firmware packages
  hardware.firmware = [
    
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;
}
