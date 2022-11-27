#!/bin/sh
apk add doas
adduser static -D -G wheel
echo 'static:123' | chpasswd
echo 'permit :wheel as root' > /etc/doas.d/doas.conf
su static