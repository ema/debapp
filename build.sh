#!/bin/sh
#
# build.sh <git url>

set -e

DEBAPP_ROOT="/tmp/debapp"

repo="$1"

tmpdir=$(mktemp -d)

cd $tmpdir

git clone --depth=1 $repo

cd *

projectname="$(basename $(pwd))"

echo $projectname > .godir

builddir=$(pwd)

echo "Building in $builddir"

for f in $(find $DEBAPP_ROOT -name detect); do
    if $f . ; then
        build=$(dirname $f)
        $build/compile . /tmp/cache /tmp
    fi
done

$DEBAPP_ROOT/debianize.sh 2>&1 | tee ../${projectname}_build.log

cd ..

rm -rf $builddir

echo "Build results available in $(pwd)"
