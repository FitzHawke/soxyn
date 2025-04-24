{pkgs, ...}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    tmp.cleanOnBoot = true;
    bootspec.enable = true;
    consoleLogLevel = 4;
    initrd.systemd.enable = true;
    # load modules on boot
    kernelModules = [];

    # https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
    kernelParams = [
      # countermeasure against attacks on the shared user/kernel address space such as “Meltdown”
      # on | off | **auto**
      # extra security for a small performance hit
      "pti=on"

      # randomize the kernel stack offset at each system call
      # y | n
      # extra security for a small performance hit
      "randomize_kstack_offset=y"

      # Controls the behavior of vsyscalls used by statically-linked binaries and older versions of glibc
      # vDSO is now generally used instead
      # emulate | **xonly** | none
      # extra security but could break system
      "vsyscall=none"

      # enables what is exposed to userspace and debugfs internal clients
      # should be off anyways, but make sure of it
      "debugfs=off"

      # This option causes fbcon to bind immediately to the fbdev device
      # might make boot visually smoother
      "fbcon=nodefer"

      # signature validation for modules
      "module.sig_enforce"

      # disable hibernate (I dont use swap)
      "noresume"

      # disable merging of slabs with similar size
      # security at the expense of slight bit of kernel memory
      "slab_nomerge"

      ###############
      # Silent Boot
      ###############

      # "quiet"
      # "loglevel=3"
      # logo.nologo
      # "systemd.show_status=auto"
      # "rd.udev.log_level=3"
      # "vt.global_cursor_default=0"

      ###############
      # Debug Helpers
      ###############

      # fairly self explanatory (0 = EMERG -> 7 = DEBUG)
      # "loglevel=7"

      # "logo.nologo"
    ];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 15;
      # dont allow editing boot commands while booting
      systemd-boot.editor = true;

      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };
  console.earlySetup = true;
}
