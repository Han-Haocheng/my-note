#!/bin/bash

export OSLAB_PATH
export EXPERIMENT_PATH
export LINUX_PATH
EXPERIMENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)
OSLAB_PATH="${EXPERIMENT_PATH%%/src*}"
LINUX_PATH="$OSLAB_PATH/linux-0.11"
cp "$EXPERIMENT_PATH"/bootsect.s "$LINUX_PATH"/boot/
cp "$EXPERIMENT_PATH"/setup.s "$LINUX_PATH"/boot/
