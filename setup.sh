#!/bin/bash

# Skrip setup untuk menginstal dan mengonfigurasi Xray, SSH, dan layanan terkait

# Update dan upgrade sistem
apt update && apt upgrade -y

# Install dependencies
apt install -y curl wget git unzip screen nano jq

# Instalasi dan Konfigurasi Xray
echo "Menginstal Xray..."
bash xray/setup.sh

# Instalasi dan Konfigurasi SSH
echo "Mengonfigurasi SSH..."
bash ssh/ssh-install.sh

# Konfigurasi SSH WebSocket
echo "Mengonfigurasi SSH WebSocket..."
bash sshws/sshws.sh

# Menjalankan konfigurasi tambahan
echo "Menjalankan konfigurasi tambahan..."
bash tools.sh
bash updatemenu.sh
bash clearlog.sh

# Mengonfigurasi firewall (UFW) untuk membuka port yang diperlukan
echo "Mengonfigurasi firewall..."
ufw allow 22/tcp   # SSH
ufw allow 443/tcp  # Xray
ufw allow 80/tcp   # WebSocket
ufw --force enable

# Menjalankan dan mengaktifkan layanan agar berjalan otomatis saat startup
echo "Mengaktifkan layanan..."
systemctl enable xray
systemctl enable ssh

echo "Setup selesai! Silakan restart VPS Anda untuk menerapkan semua perubahan."

