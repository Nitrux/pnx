#! /bin/sh


#    Install dependencies.

pacman --noconfirm -Syu base-devel wget patchelf file git yay


#    Add tooling for AppImage.

wget -q https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O appimagetool
wget -q https://raw.githubusercontent.com/Nitrux/tools/master/execs
wget -q https://raw.githubusercontent.com/Nitrux/tools/master/copier

chmod +x appimagetool
chmod +x copier
chmod +x execs


#    Copy binaries and its dependencies to appdir.

./copier \
	appdir \
	/bin/bash \
	$(./execs appdir/pnx) \
	$(pacman -Qql pacman | grep -E '(bin|makepkg)/.+[^/]$')


#    Variables for generating the AppImage.

export \
	ARCH=$(uname -m) \
	TRAVIS_COMMIT=${1:0:7} \
	TRAVIS_BRANCH=$2

RELEASE_NAME="pnx-$TRAVIS_BRANCH-$ARCH.AppImage"
UPDATE_URL="zsync|https://github.com/Nitrux/pnx/releases/download/continuous-$TRAVIS_BRANCH/$RELEASE_NAME"


#    Write the commit hash that generated this build.

sed -i "s/@_COMMIT@/$TRAVIS_COMMIT/" appdir/pnx


#    Generate the AppImage.

(
	cd appdir

	wget -q https://raw.githubusercontent.com/AppImage/AppImages/master/functions.sh
	chmod +x functions.sh
	. ./functions.sh
	delete_blacklisted
	rm functions.sh

	test -d lib/x86_64-linux-gnu &&
		find lib/x86_64-linux-gnu -type f -exec patchelf --set-rpath '$ORIGIN/././' {} \;
	test -d bin &&
		find bin -type f -exec patchelf --set-rpath '$ORIGIN/../lib/x86_64-linux-gnu' {} \;
	test -d sbin &&
		find sbin -type f -exec patchelf --set-rpath '$ORIGIN/../lib/x86_64-linux-gnu' {} \;
	test -d usr/bin &&
		find usr/bin -type f -exec patchelf --set-rpath '$ORIGIN/../../lib/x86_64-linux-gnu' {} \;
	test -d usr/sbin &&
		find usr/sbin -type f -exec patchelf --set-rpath '$ORIGIN/../../lib/x86_64-linux-gnu' {} \;
)

mkdir out
wget -q https://raw.githubusercontent.com/Nitrux/tools/master/aw
chmod +x aw
./aw appimagetool -u "$UPDATE_URL" appdir out/"$RELEASE_NAME"
