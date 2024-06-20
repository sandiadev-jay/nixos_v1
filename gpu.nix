{ config, lib, pkgs, ... }:

{

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Laptop required config for dual GPU setup
    prime = {
      sync.enable = lib.mkOverride 990 true;
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = lib.mkDefault "PCI:0:2:0";
      nvidiaBusId = lib.mkDefault "PCI:1:0:0";
    };

  };

  # Also putting config for the Intel GPU in here
  options.hardware.intelgpu.driver = lib.mkOption {
    description = "Intel GPU driver to use";
    type = lib.types.enum [
      "i915"
      "xe"
    ];
    default = "xe";  # Try out the new xe driver
  };

  options.hardware.intelgpu.loadInInitrd =
    lib.mkEnableOption (
      lib.mdDoc "Load the Intel GPU kernel module at stage 1 boot. (Added to `boot.initrd.kernelModules`)"
    )
    // {
      default = true;
    };

  config = {
    boot.initrd.kernelModules = [ config.hardware.intelgpu.driver ];

    environment.variables = {
      VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
    };

    hardware.opengl.extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
    ];

    hardware.opengl.extraPackages32 = with pkgs.driversi686Linux; [
       intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ];

    # I don't think I need this as I am running 6.9.4 currently
    # assertions = [
    #   {
    #     assertion = (
    #       config.hardware.intelgpu.driver != "xe"
    #       || lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.8"
    #     );
    #     message = "Intel Xe GPU driver is not supported on kernels earlier than 6.8. Update or use the i915 driver.";
    #   }
    # ];
  };

}