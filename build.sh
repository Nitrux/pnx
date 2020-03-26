#! /bin/sh


#    Install dependencies.

pacman --noconfirm -Syu base-devel wget patchelf file git


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
	bash \
	$(./execs appdir/*)


#    Variables for generating the AppImage.

export \
	ARCH=$(uname -m) \
	TRAVIS_COMMIT=${1:0:7} \
	TRAVIS_BRANCH=$2

RELEASE_NAME="pnx-$TRAVIS_BRANCH-$ARCH.AppImage"
UPDATE_URL="zsync|https://github.com/Nitrux/pnx/releases/download/continuous-$TRAVIS_BRANCH/$RELEASE_NAME"


#    Write the commit hash that generated this build.

sed -i "s/@TRAVIS_COMMIT@/$TRAVIS_COMMIT/" appdir/pnx


#    Generate the AppImage.

(
	cd appdir

	wget -q https://raw.githubusercontent.com/AppImage/AppImages/master/functions.sh
	chmod +x functions.sh
	. ./functions.sh
	delete_blacklisted
	rm functions.sh

	find lib/x86_64-linux-gnu -type f -exec patchelf --set-rpath '$ORIGIN/././' {} \;
	find bin -type f -exec patchelf --set-rpath '$ORIGIN/../lib/x86_64-linux-gnu' {} \;
	find sbin -type f -exec patchelf --set-rpath '$ORIGIN/../lib/x86_64-linux-gnu' {} \;
	find usr/bin -type f -exec patchelf --set-rpath '$ORIGIN/../../lib/x86_64-linux-gnu' {} \;
	find usr/sbin -type f -exec patchelf --set-rpath '$ORIGIN/../../lib/x86_64-linux-gnu' {} \;
)

wget -q https://raw.githubusercontent.com/Nitrux/tools/master/aw
chmod a+x aw

mkdir out
./aw appimagetool -u "$UPDATE_URL" appdir out/$RELEASE_NAME
