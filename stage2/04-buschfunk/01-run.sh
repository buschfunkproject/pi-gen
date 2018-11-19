#!/bin/bash -e

install -m 644 files/boot/config.txt "${ROOTFS_DIR}/boot/"
install -m 644 files/boot/cmdline.txt "${ROOTFS_DIR}/boot/"

install -m 755 files/mesh.sh "${ROOTFS_DIR}/bin/"
install -m 644 files/interfaces "${ROOTFS_DIR}/etc/network/"
install -m 644 files/interfaces.d/mesh "${ROOTFS_DIR}/etc/network/interfaces.d/"
install -m 644 files/interfaces.d/ap "${ROOTFS_DIR}/etc/network/interfaces.d/"

install -d "${ROOTFS_DIR}/etc/systemd/system/networking.service.d/"
install -m 644 files/reduce-timeout.conf "${ROOTFS_DIR}/etc/systemd/system/networking.service.d/"

on_chroot << \EOF
systemctl disable dhcpcd.service
echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> /etc/default/hostapd
EOF

install -m 644 files/hostapd.conf "${ROOTFS_DIR}/etc/hostapd/"

install -m 644 files/dnsmasq.d/ap "${ROOTFS_DIR}/etc/dnsmasq.d/"
install -m 644 files/dnsmasq.d/ap_ns "${ROOTFS_DIR}/etc/dnsmasq.d/"

# on_chroot << \EOF
# iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
# iptables -t nat -A  POSTROUTING -o wlan0 -j MASQUERADE
# sh -c "iptables-save > /etc/iptables.ipv4.nat"
# EOF
install -m 755 files/load-nat.sh "${ROOTFS_DIR}/etc/"

on_chroot << \EOF
touch /boot/ssh
EOF

install -m 644 files/heckenschere/boot/buschfunk.txt "${ROOTFS_DIR}/boot/"
install -m 755 files/heckenschere/heckenschere.py "${ROOTFS_DIR}/bin/"

on_chroot << \EOF
wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs
cd /home/pi
git clone https://github.com/buschfunkproject/bledebug
chown -R pi:pi bledebug
EOF

install -m 644 files/bledebug.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << \EOF
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
usermod -aG docker pi
EOF

