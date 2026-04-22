#!/bin/sh
export RELEASE=3.23.4
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH=x86_64 ;;
    amd64) ARCH=x86_64 ;;
    aarch64) ARCH=aarch64 ;;
    arm64) ARCH=aarch64 ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac
echo "RELEASE=$RELEASE" >> "$GITHUB_OUTPUT"
echo "ARCH=$ARCH" >> "$GITHUB_OUTPUT"


# start build
curl -LO "https://dl-cdn.alpinelinux.org/alpine/v${RELEASE:0:4}/releases/$ARCH/alpine-minirootfs-$RELEASE-$ARCH.tar.gz"
mkdir -p ./alpinewsl
sudo tar -xzpf alpine-minirootfs-$RELEASE-$ARCH.tar.gz -C ./alpinewsl
sudo cp ./wslconf/oobe.sh ./alpinewsl/etc/oobe.sh
sudo chmod 644 ./alpinewsl/etc/oobe.sh
sudo chmod +x ./alpinewsl/etc/oobe.sh
sudo cp ./wslconf/wsl-distribution-stable.conf ./alpinewsl/etc/wsl-distribution.conf
sudo chmod 644 ./alpinewsl/etc/wsl-distribution.conf
sudo mkdir -p ./alpinewsl/usr/lib/wsl/
sudo curl -L https://raw.githubusercontent.com/yuk7/wsldl/refs/heads/main/res/Alpine/icon.ico --output ./alpinewsl/usr/lib/wsl/icon.ico

cat <<-EOF | sudo unshare -mpf bash -e -
sudo mount --bind /dev ./alpinewsl/dev
sudo mount --bind /proc ./alpinewsl/proc
sudo mount --bind /sys ./alpinewsl/sys
sudo echo 'nameserver 1.1.1.1' >> ./alpinewsl/etc/resolv.conf

sudo chroot ./alpinewsl apk update
sudo chroot ./alpinewsl apk upgrade
sudo chroot ./alpinewsl apk add bash sudo shadow
EOF

cd ./alpinewsl
sudo tar --numeric-owner --absolute-names -c  * | gzip --best > ../install.tar.gz
mv ../install.tar.gz ../alpine-stable-$ARCH.wsl