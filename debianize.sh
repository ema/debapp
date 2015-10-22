#!/bin/sh

pkgname=$(basename $(pwd))
dstdir="/opt/${pkgname}/"

dh_make -y --single -n -p ${pkgname}_0.0.0

# Do not run make
(echo "override_dh_auto_clean:";
 echo "override_dh_auto_build:";
 echo "override_dh_auto_test:") >> debian/rules

# Include everything except source code
find . | grep -v '\.go$' | grep -v '\.git' | grep -v '^./debian' |
    sed "s#\$# $dstdir#" | awk 'NR > 1' > debian/${pkgname}.install

dpkg-buildpackage -rfakeroot -us -uc
