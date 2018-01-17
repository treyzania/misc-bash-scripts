#!/bin/bash

# This is a variant of the Maven packaing script.  I used it in my systems
# class for packaging the sources into a .tar.gz file.

arc_files='*.c *.h Makefile'
dname=$(basename $(realpath .))
prefix=$dname

# Add in extra files
if [ -f package-extras ]; then
	exf=$(cat package-extras)
	arc_files="$arc_files $exf"
fi

# Figure out the versioning information.
commit=$(git rev-parse --short HEAD)
suffix=
if [ -n "$(git status --untracked-files --porcelain)" ]; then
	suffix='-dirty'
fi

# The actual name of the file.
arc_name="$prefix-$commit$suffix.tar.gz"

# Create the packaging directory.
pkgdir=pkgtmp/$dname
mkdir -p $pkgdir
for f in $arc_files; do
	cp -r $f $pkgdir
done

# Cleanup.
rm -f $prefix-*.tar.gz

# Actually do things.
echo -e "\e[1mPackaging...\e[0m"
pushd pkgtmp > /dev/null
tar -cvzf $arc_name $dname
mv $arc_name* ..
popd > /dev/null
rm -rf pkgtmp

