#!/bin/bash

# ===== ipv6toggle.sh 1.0 by TensorTom ===== #
#
# Github: https://github.com/TensorTom/ipv6toggle
#
#     -- License --
# GNU GENERAL PUBLIC LICENSE
# Version 3, 29 June 2007
# https://github.com/TensorTom/ipv6toggle/blob/master/LICENSE
#
# =========================================+ #

displayHelp() {
    echo "================ ipv6toggle =================="
    echo "Toggle IPv6 connectivity of the system on/off."
    echo "----------------------------------------------"
    echo
    echo "Usage: sudo $0 {on|off} <or> {enable|disable}" >&2
    echo
    echo "   -h, --help           Display this help message."
    echo
    exit 1
}

disable() {
    enable 0
    $SUDO echo "# Disable IPv6 (ipv6toggle.sh) start
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
# Disable IPv6 (ipv6toggle.sh) end" >> /etc/sysctl.d/99-sysctl.conf
    exit 1
}

enable() {
    $SUDO sed -i '/# Disable IPv6 (ipv6toggle.sh) start/d' /etc/sysctl.d/99-sysctl.conf
    $SUDO sed -i '/net.ipv6.conf.all.disable_ipv6 = 1/d' /etc/sysctl.d/99-sysctl.conf
    $SUDO sed -i '/net.ipv6.conf.default.disable_ipv6 = 1/d' /etc/sysctl.d/99-sysctl.conf
    $SUDO sed -i '/net.ipv6.conf.lo.disable_ipv6 = 1/d' /etc/sysctl.d/99-sysctl.conf
    $SUDO sed -i '/# Disable IPv6 (ipv6toggle.sh) end/d' /etc/sysctl.d/99-sysctl.conf
    if [ !actual ] ; then return 1 ; fi
    exit 1
}

SUDO=""
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

case "$1" in
    -h | --help | -help)
        displayHelp
        ;;
    enable | on)
        enable 1
        exit 1;
        ;;
    disable | off)
        disable
        exit 1;
        ;;
    *)
        echo "Invalid input. Run '$0 -h' to see usage."
        exit 1;
        ;;
esac


display_help
