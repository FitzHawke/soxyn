{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    tmp.cleanOnBoot = true;
    bootspec.enable = true;
    consoleLogLevel = 0;
    # some kernel parameters, i dont remember what half of this shit does but who cares
    kernelParams = [
      "pti=on"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "acpi_call"
      "processor.max_cstate=5"
      "slab_nomerge"
      "debugfs=off"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "page_poison=1"
      "page_alloc.shuffle=1"
      "slub_debug=FZP"
      "sysrq_always_enabled=1"
      "idle=nomwait"
      "rootflags=noatime"
      "iommu=pt"
      "usbcore.autosuspend=-1"
      "sysrq_always_enabled=1"
      "lsm=landlock,lockdown,yama,apparmor,bpf"
      "loglevel=7"
      "rd.udev.log_priority=3"
      "noresume"
      "quiet"
      "logo.nologo"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ];
    initrd.systemd.enable = true;
    initrd.verbose = false;
    # switch from old ass lts kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
    extraModprobeConfig = "options hid_apple fnmode=1";

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 15;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  console.earlySetup = true;
}