#!/bin/bash
DEVICE=$1
IMG_FOLDER=${PWD}

# UEFI dir. Downloaded from
#   https://builds.96boards.org/snapshots/reference-platform/components/uefi-staging/
#   Eg: 26/hikey970/release/
# Then, modify UEFI_BUILD_PATH accordingly.
UEFI_BUILD_PATH=/home/qubo/tools-images-hikey970

if [ "${DEVICE}" == "" ]; then
	DEVICE=/dev/ttyUSB0
fi

cd ${UEFI_BUILD_PATH}
sudo ${UEFI_BUILD_PATH}/hikey_idt -c ${UEFI_BUILD_PATH}/config -p ${DEVICE}

# partition table
fastboot flash ptable ${UEFI_BUILD_PATH}/prm_ptable.img

# bootloader
fastboot flash xloader ${UEFI_BUILD_PATH}/sec_xloader.img
fastboot flash fastboot ${UEFI_BUILD_PATH}/l-loader.bin
fastboot flash fip ${UEFI_BUILD_PATH}/fip.bin

# kernel ramdisk dt
fastboot flash boot ${UEFI_BUILD_PATH}/boot.img

fastboot flash cache ${UEFI_BUILD_PATH}/cache.img

fastboot flash system ${UEFI_BUILD_PATH}/system.img

fastboot flash userdata ${UEFI_BUILD_PATH}/userdata.img
