{ config, lib, pkgs, ... }:

{

  # Enable OpenGL (renamed to graphics)
  hardware.graphics = {
    enable = true;
    # This appears to have made my GPU unfindable
    # package = config.boot.kernelPackages.nvidiaPackages.stable;  # Set Nvidia driver (to fix NVK requires nouveau errors)
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ]; 
    extraPackages32 = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"];

  # Accept Nvidia license
  # nixpkgs.config.nvidia.acceptLicense = true;

  # Nvidia config
  # hardware.nvidia = {

  #   # Modesetting is required.
  #   modesetting.enable = true;

  #   # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #   # Enable this if you have graphical corruption issues or application crashes after waking
  #   # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  #   # of just the bare essentials.
  #   powerManagement.enable = false;  # Setting back to false to try to fix hibernate issues

  #   # Fine-grained power management. Turns off GPU when not in use.
  #   # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #   powerManagement.finegrained = false;

  #   # Use the NVidia open source kernel module (not to be confused with the
  #   # independent third-party "nouveau" open source driver).
  #   # Support is limited to the Turing and later architectures. Full list of 
  #   # supported GPUs is at: 
  #   # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  #   # Only available from driver 515.43.04+
  #   # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #   open = false;

  #   # Enable the Nvidia settings menu,
  #   # accessible via `nvidia-settings`.
  #   nvidiaSettings = true;

  #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;

  #   # Laptop required config for dual GPU setup
  #   prime = {
  #     sync.enable = true;
  #     # Make sure to use the correct Bus ID values for your system!
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };

  # };

  # Also putting config for the Intel GPU in here
  # xe requires linux kernelt 6.8 or newer (running 6.9.4)
  # Trying out the new "xe" driver (other option "i915")
  # Load the Intel GPU kernel module at stage 1 boot (added to 'boot.initrd.kernelModules').
  boot.initrd.kernelModules = [ "xe" ];
  
  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    # VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";  # Attempting to fix NVK requires Nouveau error
  };
}
