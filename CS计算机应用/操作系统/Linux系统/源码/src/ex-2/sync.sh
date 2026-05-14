#!/bin/bash
export OSLAB_PATH
export EXPERIMENT_PATH
export LINUX_PATH
export IMAGE_PATH

EXPERIMENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)
OSLAB_PATH="${EXPERIMENT_PATH%%/src*}"
LINUX_PATH="$OSLAB_PATH/linux-0.11"
IMAGE_PATH="$OSLAB_PATH/hdc"

cp "$EXPERIMENT_PATH/Makefile" "$LINUX_PATH/kernel/"
cp "$EXPERIMENT_PATH/system_call.s" "$LINUX_PATH/kernel/"
cp "$EXPERIMENT_PATH/who.c" "$LINUX_PATH/kernel/"

cp "$EXPERIMENT_PATH/sys.h" "$LINUX_PATH/include/"
cp "$EXPERIMENT_PATH/unistd.h" "$LINUX_PATH/include/"

sudo mount -t minix -o loop,offset=1024 "$OSLAB_PATH"/hdc-0.11.img "$OSLAB_PATH"/hdc
cp "$EXPERIMENT_PATH"/testlab2.c "$IMAGE_PATH"/usr/root/
cp "$EXPERIMENT_PATH"/whoami.c "$IMAGE_PATH"/usr/root/
cp "$EXPERIMENT_PATH"/iam.c "$IMAGE_PATH"/usr/root/
cp "$EXPERIMENT_PATH"/testlab2.sh "$IMAGE_PATH"/usr/root/
cp "$EXPERIMENT_PATH"/run.sh "$IMAGE_PATH"/usr/root/
cp -r "$LINUX_PATH/include/" "$IMAGE_PATH/usr/"
sudo umount hdc


