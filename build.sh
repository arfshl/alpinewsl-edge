#!/bin/sh
export RELEASE=20260127
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
echo "RELEASE=$RELEASE" >> "$GITHUB_ENV"
echo "ARCH=$ARCH" >> "$GITHUB_ENV"


# start build
curl -LO "https://dl-cdn.alpinelinux.org/alpine/edge/releases/$ARCH/alpine-minirootfs-$RELEASE-$ARCH.tar.gz"
mkdir -p ./alpinewsl
sudo tar -xzpf alpine-minirootfs-$RELEASE-$ARCH.tar.gz -C ./alpinewsl
cp ./oobe.sh ./alpinewsl/etc/oobe.sh
chmod 777 ./alpinewsl/etc/oobe.sh
chmod +x ./alpinewsl/etc/oobe.sh
cp ./wsl-distribution.conf ./alpinewsl/etc/wsl-distribution.conf
chmod 777 ./alpinewsl/etc/wsl-distribution.conf
sudo mkdir -p ./alpinewsl/usr/lib/wsl/
sudo curl -L https://raw.githubusercontent.com/yuk7/wsldl/refs/heads/main/res/Alpine/icon.ico --output ./alpinewsl/usr/lib/wsl/icon.ico

cat <<-EOF | sudo unshare -mpf bash -e -
sudo mount --bind /dev ./alpinewsl/dev
sudo mount --bind /proc ./alpinewsl/proc
sudo mount --bind /sys ./alpinewsl/sys
sudo echo 'nameserver 1.1.1.1' >> ./alpinewsl/etc/resolv.conf

sudo chroot ./alpinewsl apk update
sudo chroot ./alpinewsl apk upgrade
sudo chroot ./alpinewsl apk add bash sudo
EOF

cd ./alpinewsl
sudo tar --numeric-owner --absolute-names -c  * | gzip --best > ../install.tar.gz
mv ../install.tar.gz ../alpine-wsl-edge.wsl