#!/bin/bash -e

ROOTFS="$WORK/rootfs/"
OUTPUT="$WORK/output"
TARFILE="${OUTPUT}/rootfs.tar"

mkdir -p "$OUTPUT"

if [[ "$IMAGE_ROOTFS_TAR_NONE" == 'y' ]]; then
        COMPRESSION=""
elif [[ "$IMAGE_ROOTFS_TAR_XZ" == 'y' ]]; then
        COMPRESSION="J"
        export XZ_OPT="-T0" # use multiple threads
        TARFILE="${TARFILE}.xz"
elif [[ "$IMAGE_ROOTFS_TAR_BZIP2" == 'y' ]]; then
        COMPRESSION="j"
        TARFILE="${TARFILE}.bz2"
else 
        echo "Invalid compresion!"
        exit 1
fi

cd $ROOTFS
tar c${COMPRESSION}f "$TARFILE" .
