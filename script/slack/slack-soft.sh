#!/bin/sh

PRGNAM=
VERSION=
SUFFIX=
ARCH=${ARCH:-i486}
BUILD=${BUILD:-1}
TAG=${TAG:-_TAo}

CWD=$(pwd)
TMP=${TMP:-/tmp/TAo}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

if [ "$ARCH" = "i486" ]; then
  SLKCFLAGS="-O2 -march=i486 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
fi

set -e

echo "rm and mkdir ..."
sudo rm -rf $PKG
mkdir -p $TMP $PKG $OUTPUT
#cd $TMP
#rm -rf $PRGNAM-$VERSION
#tar xvf $CWD/$PRGNAM-$VERSION.$SUFFIX
#cd $PRGNAM-$VERSION
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;

CFLAGS="$SLKCFLAGS" \
CXXFLAGS="$SLKCFLAGS" \
./configure \
  --prefix=/usr/local \
  --localstatedir=/var \
  --build=$ARCH-slackware-linux
  # --sysconfdir=/etc

make
make install DESTDIR=$PKG

find $PKG | xargs file | grep -e "executable" -e "shared object" | grep ELF \
  | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null || true

( cd $PKG/usr/local/share/man
  find . -type f -exec gzip -9 {} \;
  for i in $(find . -type l) ; do ln -s $( readlink $i ).gz $i.gz ; rm $i ; done
)


#mkdir -p $PKG/install
#cat $CWD/slack-desc > $PKG/install/slack-desc

cd $PKG
echo "chown -R root:root ."
sudo chown -R root:root .
sudo /sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-txz}
