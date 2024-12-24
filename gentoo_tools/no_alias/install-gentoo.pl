#!/usr/bin/env perl

use strict;

# exec vs. system
# system will allow child processes and exit after completion
system(
    'emerge app-admin/eclean-kernel &&
    emerge app-admin/keepassxc &&
    emerge app-admin/sudo &&
    emerge app-admin/sysklogd &&
    #emerge app-benchmarks/phoronix-test-suite &&
    emerge app-editors/emacs &&
    emerge app-editors/neovim &&
    emerge app-editors/vim &&
    #emerge app-emulation/LookingGlass &&
    emerge app-emulation/qemu &&
    emerge app-emulation/virt-manager &&
    emerge app-emulation/winetricks &&
    emerge app-eselect/eselect-repository &&
    # need to add repos first
    #emerge app-i18n/fcitx-configtool::gentoo-zh &&
    #emerge app-i18n/mozc::gentoo-zh &&
    emerge app-misc/abook &&
    #emerge app-misc/anki &&
    emerge app-misc/neofetch &&
    #emerge app-misc/piper &&
    #emerge app-misc/radeontop &&
    emerge app-misc/screen &&
    emerge app-portage/cpuid2cpuflags &&
    emerge app-portage/eix &&
    emerge app-portage/genlop &&
    emerge app-portage/gentoolkit &&
    #emerge app-portage/pfl &&
    emerge app-shells/gentoo-zsh-completions &&
    emerge app-shells/ksh &&
    emerge app-shells/tcsh &&
    emerge app-shells/zsh &&
    emerge app-shells/zsh-syntax-highlighting &&
    emerge app-text/doxygen &&
    emerge app-vim/gentoo-syntax &&
    #emerge cross-i686-w64-mingw32/binutils &&
    # cross-dev needs special handling!
    #emerge cross-i686-w64-mingw32/gcc &&
    #emerge cross-i686-w64-mingw32/mingw64-runtime &&
    #emerge cross-x86_64-w64-mingw32/binutils &&
    #emerge cross-x86_64-w64-mingw32/gcc &&
    #emerge cross-x86_64-w64-mingw32/mingw64-runtime &&
    emerge dev-build/cmake &&
    emerge dev-cpp/nlohmann_json &&
    emerge dev-debug/gdb &&
    emerge dev-debug/valgrind &&
    emerge dev-java/openjdk &&
    emerge dev-libs/boost &&
    emerge dev-libs/jemalloc &&
    emerge dev-libs/wayland &&
    emerge dev-python/pip &&
    #emerge dev-qt/qt-creator &&
    #emerge dev-qt/qtwayland &&
    emerge dev-scheme/racket &&
    emerge dev-util/cloc &&
    emerge dev-util/debugedit &&
    #emerge dev-util/vulkan-tools &&
    emerge dev-vcs/git &&
    #emerge games-util/lutris &&
    #emerge games-util/steam-launcher &&
    emerge gui-apps/grim &&
    emerge gui-apps/hyprpaper &&
    emerge gui-apps/hyprpicker &&
    emerge gui-apps/rofi-wayland &&
    emerge gui-apps/slurp &&
    emerge gui-apps/swayidle &&
    #emerge gui-apps/swaylock-effects &&
    emerge gui-apps/waybar &&
    emerge gui-apps/wl-clipboard &&
    emerge gui-libs/display-manager-init &&
    emerge gui-libs/xdg-desktop-portal-hyprland &&
    emerge gui-libs/xdg-desktop-portal-wlr &&
    emerge gui-wm/hyprland &&
    emerge kde-apps/ark &&
    emerge kde-apps/gwenview &&
    emerge kde-apps/kate &&
    emerge kde-apps/kcalc &&
    emerge kde-apps/kdenlive &&
    emerge kde-apps/kolourpaint &&
    emerge kde-apps/kruler &&
    emerge kde-apps/okular &&
    emerge kde-apps/spectacle &&
    emerge kde-misc/skanlite &&
    emerge mail-client/mutt-wizard &&
    emerge mail-client/neomutt &&
    emerge media-fonts/fira-mono &&
    emerge media-fonts/fira-sans &&
    emerge media-fonts/fonts-meta &&
    emerge media-fonts/hack &&
    #emerge media-gfx/blender &&
    emerge media-gfx/gimp &&
    emerge media-gfx/inkscape &&
    emerge media-gfx/krita &&
    emerge media-gfx/plantuml &&
    emerge media-libs/libglvnd &&
    emerge media-libs/libpulse &&
    emerge media-libs/libsfml &&
    #emerge media-libs/mesa &&
    emerge media-sound/elisa &&
    emerge media-sound/fluidsynth &&
    emerge media-sound/playerctl &&
    emerge media-sound/scream &&
    emerge media-tv/v4l-utils &&
    #emerge media-video/amdgpu-pro-amf &&
    emerge media-video/obs-studio &&
    emerge media-video/pipewire &&
    emerge media-video/v4l2loopback &&
    emerge media-video/vlc &&
    emerge media-video/wireplumber &&
    emerge net-dns/avahi &&
    emerge net-ftp/filezilla &&
    emerge net-im/discord &&
    emerge net-irc/irssi &&
    emerge net-misc/adjtimex &&
    emerge net-misc/chrony &&
    emerge net-misc/keychain &&
    emerge net-misc/netifrc &&
    emerge net-print/cups &&
    emerge net-print/cups-meta &&
    emerge sys-apps/cpuid &&
    emerge sys-apps/fd &&
    #emerge sys-apps/flatpak &&
    emerge sys-apps/hwinfo &&
    emerge sys-apps/hwloc &&
    emerge sys-apps/lm-sensors &&
    emerge sys-apps/lshw &&
    emerge sys-apps/mlocate &&
    emerge sys-apps/ripgrep &&
    emerge sys-apps/usbutils &&
    #emerge sys-auth/google-authenticator &&
    #emerge sys-auth/oath-toolkit &&
    emerge sys-auth/seatd &&
    emerge sys-block/gparted &&
    emerge sys-block/io-scheduler-udev-rules &&
    emerge sys-boot/grub &&
    emerge sys-boot/os-prober &&
    #emerge sys-boot/unetbootin &&
    #emerge sys-devel/crossdev &&
    #emerge sys-firmware/intel-microcode &&
    emerge sys-fs/btrfs-progs &&
    emerge sys-fs/dosfstools &&
    emerge sys-fs/udisks &&
    #emerge sys-kernel/gentoo-kernel &&
    emerge sys-kernel/installkernel &&
    emerge sys-kernel/linux-firmware &&
    emerge sys-libs/libhugetlbfs &&
    emerge sys-process/btop &&
    emerge sys-process/dcron &&
    emerge virtual/opengl &&
    emerge virtual/wine &&
    #emerge www-client/firefox &&
    emerge www-client/firefox-bin &&
    emerge www-client/links &&
    emerge www-client/lynx &&
    #emerge x11-apps/mesa-progs &&
    emerge x11-base/xorg-drivers &&
    emerge x11-base/xorg-server &&
    emerge x11-misc/copyq &&
    emerge x11-misc/dunst &&
    emerge x11-misc/qt5ct &&
    emerge x11-misc/zim &&
    emerge x11-terms/kitty &&
    emerge x11-themes/adwaita-qt &&
    #emerge x11-wm/hypr &&
    emerge xfce-base/thunar &&
    emerge xfce-base/tumbler'
);

# inspect system() failure if it fails
if ($? == -1) {
    print "failed to execute: $!\n";
}
elsif ($? & 127) {
    printf "child died with signal %d, %s coredump\n",
        ($? & 127),  ($? & 128) ? 'with' : 'without';
}
else {
    printf "child exited with value %d\n", $? >> 8;
}
