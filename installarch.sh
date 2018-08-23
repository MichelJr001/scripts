#!/bin/bash

# @author: Michel Anderson
# @Github: MichelJr001
# @Twitter: _Michel_Jr_

clear

echo -e """
\033[31m
\t\t _____           _        _ _                  _     
\t\t|_   _|         | |      | | |                | |\033[32mv1.0\033[31m 
\t\t  | |  _ __  ___| |_ __ _| | |   __ _ _ __ ___| |__  
\t\t  | | | '_ \/ __| __/ _  | | |  / _  | '__/ __| '_ \ 
\t\t _| |_| | | \__ \ || (_| | | | | (_| | | | (__| | | |
\t\t|_____|_| |_|___/\__\__,_|_|_|  \__,_|_|  \___|_| |_|\n

 \033[32mGithub:\033[0m https://github.com/MichelJr001
 \033[32mtwitter:\033[0m https://twitter.com/_Michel_Jr_


Iniciando instalação...\n"""

# Muda o layout do teclado
echo -e "[ \033[32minstallarch \033[0m]: Mudando layout do teclado..."
loadkeys br-abnt2
echo -e "[ \033[32mOK \033[0m]"

# Inicia o particionador de hd
echo -e "[ \033[32minstallarch \033[0m]: Iniciando particionador de HD..."
cfdisk
echo -e "[ \033[32mOK \033[0m]"

# Monta as partições criadas
echo -e "[ \033[32minstallarch \033[0m]: Montando partições..."
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
lsblk
echo -e "[ \033[32mOK \033[0m]"

# Instala o sistema basico nas partições montadas
echo -e "[ \033[32minstallarch \033[0m]: Instalando o sistema basico..."
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab
echo -e "[ \033[32mOK \033[0m]"

# Configura o sistema basico
echo -e "[ \033[32minstallarch \033[0m]: Configurando o sistema basico..."
arch-chroot /mnt
locale-gen
LANG="pt_PT.UTF-8" locale > /etc/locale.conf
echo "KEYMAP=pt-latin9" > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Lisbon /etc/localtime
mkinitcpio -p linux
echo -e "[ \033[32mOK \033[0m]"

# Instala o inicializador GRUB
echo -e "[ \033[32minstallarch \033[0m]: Inicinado instalação do GRUB..."
pacman -S grub
grub-install /dev/sda
pacman -S os-prober
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "[ \033[32mOK \033[0m]"

# Configura e adiciona mais usuarios
echo -e "[ \033[32minstallarch \033[0m]: Configurando usuarios..."
echo -e "[ \033[32minstallarch \033[0m]: Senha de root..."
passwd
echo -e "[ \033[32minstallarch \033[0m]: Novo usuario..."
echo -e "[ \033[33mnome\033[0m ]: "
read nome
useradd -m $nome
passwd $nome 
echo -e "[ \033[32mOK \033[0m]"

# Desmonta a partição e reinicia o sistema
echo -e "[ \033[32minstallarch \033[0m]: Finalizando instalação..."
umount /mnt
clear
echo -e "
\033[31m
\t\t _____           _        _ _                  _     
\t\t|_   _|         | |      | | |                | |\033[32mv1.0\033[31m 
\t\t  | |  _ __  ___| |_ __ _| | |   __ _ _ __ ___| |__  
\t\t  | | | '_ \/ __| __/ _  | | |  / _  | '__/ __| '_ \ 
\t\t _| |_| | | \__ \ || (_| | | | | (_| | | | (__| | | |
\t\t|_____|_| |_|___/\__\__,_|_|_|  \__,_|_|  \___|_| |_|\n

 \033[32mGithub:\033[0m https://github.com/MichelJr001
 \033[32mtwitter:\033[0m https://twitter.com/_Michel_Jr_

 Retire o disco de instalação
"
sleep 3
reboot