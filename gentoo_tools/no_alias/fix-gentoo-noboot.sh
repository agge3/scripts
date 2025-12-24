if [[ true -eq false ]]; then
	# pre-setup
	mkdir -p /mnt/gentoo
	# `fdisk -l | grep nvme` for root partition
	mount --types proc /proc /mnt/gentoo/proc
	mount --rbind /sys /mnt/gentoo/sys
	mount --rbind /dev /mnt/gentoo/dev
	mount --bind /run /mnt/gentoo/run
	mount --make-rslave /mnt/gentoo/sys
	mount --make-rslave /mnt/gentoo/dev
	mount --make-slave /mnt/gentoo/run

	chroot /mnt/gentoo /bin/bash
	su "$MY_USER"
	mount -a
fi

sudo mount /dev/nvme1n1p1 /boot

sudo emerge --ask --newuse --oneshot sys-boot/grub

sudo grub-install --target=x86_64-efi --efi-directory=/boot
sudo grub-mkconfig -o /boot/grub/grub.cfg

# FINISH
umount -a
exit
umount -l /mnt/gentoo/{dev,proc,sys,run,}
sync
reboot
