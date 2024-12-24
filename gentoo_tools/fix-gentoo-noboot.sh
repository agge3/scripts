sudo mount /dev/nvme1n1p1 /boot

sudo emerge --ask --newuse --oneshot sys-boot/grub

sudo grub-install --target=x86_64-efi --efi-directory=/boot
sudo grub-mkconfig -o /boot/grub/grub.cfg
