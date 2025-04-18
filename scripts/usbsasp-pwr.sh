#!/bin/bash

# Define GPIO pins
GPIO_3V3=44  # Change to your actual GPIO for 3V3
GPIO_5V=45   # Change to your actual GPIO for 5V

# Ensure script is run as root
#if [ "$(id -u)" -ne 0 ]; then
#    echo "Error: This script must be run as root (use sudo)."
#    exit 1
#fi

# Function to enable a GPIO (set as output high)
enable_gpio() {
    local pin=$1
    raspi-gpio set $pin op dh  # Set as output, drive high
}

# Function to disable a GPIO
disable_gpio() {
    local pin=$1
    raspi-gpio set $pin op dl
}

# Process argument
case "$1" in
    "3V3")
        enable_gpio $GPIO_3V3
        disable_gpio $GPIO_5V
        echo "Set 3V3 target power"
        ;;
    "5V")
        enable_gpio $GPIO_5V
        disable_gpio $GPIO_3V3
        echo "Set 5V target power"
        ;;
    "none")
        disable_gpio $GPIO_3V3
        disable_gpio $GPIO_5V
        echo "Disabled target power"
        ;;
    *)
        echo "Usage: $0 {none|3V3|5V}"
        exit 1
        ;;
esac

exit 0
