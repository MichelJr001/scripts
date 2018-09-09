#!/bin/bash

# @author: Michel Anderson
# @Github: MichelJr001
# @Twitter: _Michel_Jr_

clear

# Cores a serem usadas no script
corPadrao="\033[0m"
vermelho="\033[31m"
verde="\033[32m"
amarelo="\033[33m"

echo -e """
$vermelho
\t\t _____           _        _ _                  _     
\t\t|_   _|         | |      | | |                | |$verde v1.0 $vermelho 
\t\t  | |  _ __  ___| |_ __ _| | |   __ _ _ __ ___| |__  
\t\t  | | | '_ \/ __| __/ _  | | |  / _  | '__/ __| '_ \ 
\t\t _| |_| | | \__ \ || (_| | | | | (_| | | | (__| | | |
\t\t|_____|_| |_|___/\__\__,_|_|_|  \__,_|_|  \___|_| |_|\n

 $verde Github:$corPadrao https://github.com/MichelJr001
 $verde twitter:$corPadrao https://twitter.com/_Michel_Jr_


Iniciando instalação...\n"""

sleep 3

# Muda o layout do teclado
echo -e "[$verde installarch $corPadrao]: Mudando layout do teclado..."
loadkeys br-abnt2
echo -e "[$verde OK $corPadrao]"

# Inicia o particionador de hd
echo -e "[$verde installarch $corPadrao]: Iniciando particionador de HD..."
# use o modo DOS e crie uma partição normal bootavel e uma swap
cfdisk
echo -e "[$verde OK $corPadrao]"

# Monta as partições criadas
echo -e "[$verde installarch $corPadrao]: Montando partições..."
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
echo -e "[$verde OK $corPadrao]"

# Instala o sistema basico nas partições montadas
echo -e "[$verde installarch $corPadrao]: Instalando o sistema basico..."
echo "Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab
echo -e "[$verde OK $corPadrao]"

# Configura o sistema basico
echo -e "[$verde installarch $corPadrao]: Configurando o sistema basico..."
arch-chroot /mnt
locale-gen
LANG="pt_PT.UTF-8" locale > /etc/locale.conf
echo "KEYMAP=pt-latin9" > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Lisbon /etc/localtime
echo "Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist
mkinitcpio -p linux
echo -e "[$verde OK $corPadrao]"

# Instala o inicializador GRUB
echo -e "[$verde installarch $corPadrao]: Inicinado instalação do GRUB..."
pacman -S grub
grub-install /dev/sda
pacman -S os-prober
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "[$verde OK $corPadrao]"

# Configura e adiciona mais usuarios
echo -e "[$verde installarch $corPadrao]: Configurando usuarios..."
echo -e "[$verde installarch $corPadrao]: Senha de root..."
passwd
echo -e "[$verde installarch $corPadrao]: Novo usuario..."
read -p $'[\033[33m nome\033[0m ]: ' nome
useradd -m $nome
passwd $nome 
echo -e "[$verde OK $corPadrao]"
echo -e "[$verde installarch $corPadrao]: Atualizando e baixando pacotes..."
pacman -Syuu
pacman -S xf86-video-vesa
pacman -S xfce4
pacman -S xfdm
echo -e "[$verde OK $corPadrao]"

# Desmonta a partição e reinicia o sistema
echo -e "[$verde installarch $corPadrao]: Finalizando instalação..."
systemctl enable xfdm.service
exit
umount -a
clear

echo -e "$vermelho
\t\t _____           _        _ _                  _     
\t\t|_   _|         | |      | | |                | |$verde v1.0$vermelho 
\t\t  | |  _ __  ___| |_ __ _| | |   __ _ _ __ ___| |__  
\t\t  | | | '_ \/ __| __/ _  | | |  / _  | '__/ __| '_ \ 
\t\t _| |_| | | \__ \ || (_| | | | | (_| | | | (__| | | |
\t\t|_____|_| |_|___/\__\__,_|_|_|  \__,_|_|  \___|_| |_|\n

 $verde Github:$corPadrao https://github.com/MichelJr001
 $verde twitter:$corPadrao https://twitter.com/_Michel_Jr_

 Retire o disco de instalação
"
sleep 3
# reboot
