#!/bin/bash

grubdir=/usr/share/grub2
bootfiledir=bootfiles

if test ! -d $bootfiledir; then
  mkdir $bootfiledir
fi

echo usb-bios bootfiles [boot.img+core.img]
grub2-mkimage --config=grub-emb-bios.cfg -d $grubdir/i386-pc -p /boot/grub2/bios \
    -o $bootfiledir/core.img -O i386-pc \
    biosdisk part_msdos configfile search help search_fs_file fat ntfs exfat ext2
    
if test ! -e $bootfiledir/boot.img; then
    cp $grubdir/i386-pc/boot.img $bootfiledir/boot.img
fi

echo cd-bios bootfile [g2ldr.bin]
grub2-mkimage -d $grubdir/i386-pc -p /boot/grub2/bios \
    -o $bootfiledir/core_cd.img -O i386-pc \
    biosdisk part_msdos iso9660 udf configfile search help reboot halt linux16 linux \
    chain search_fs_file fat ntfs exfat ext2 ntldr
    
cat $grubdir/i386-pc/cdboot.img $bootfiledir/core_cd.img > $bootfiledir/g2ldr.bin
rm $bootfiledir/core_cd.img

echo EFI bootfile [bootx64.efi]
grub2-mkimage --config=grub-emb-uefi.cfg -d $grubdir/x86_64-efi -p /boot/grub2/uefi \
    -o $bootfiledir/bootx64.efi -O x86_64-efi \
    search search_fs_file configfile help iso9660 udf fat part_gpt part_msdos disk exfat \
    ext2 ntfs appleldr hfs normal linux16 linux chain
