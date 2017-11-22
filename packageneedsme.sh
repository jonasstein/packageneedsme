#!/bin/bash
# This script will list all installed packages on a gentoo system 
# without maintainer or old EAPI.
# depends on eix (and portage)
# License: GPL-2
# Maintainer: Jonas Stein
# Repository: https://github.com/jonasstein/packageneedsme
#
# Changelog and authors:
# 2017-11-22 add tree path detection (Nils Freydank)
# 2017-11-17 initial script (Jonas Stein)

MYPORTDIR="$(portageq get_repo_path / gentoo)"

declare -a INSTALLED  # declare an array
INSTALLED=( $(qlist -RIC|grep gentoo| cut -f 1 -d":") )

echo "These installed packages have no maintainer. The package is waiting for you:"
for catpkg in "${INSTALLED[@]}"
do
	grep -q "<!-- maintainer-needed -->" "${MYPORTDIR}"/$catpkg/metadata.xml && echo $catpkg
done

echo 
echo "These installed packages use a very old EAPI. You can prepare a PR:"
INSTALLED=( $(EIX_LIMIT=0 eix --installed --in-overlay 0 --only-names --installed-eapi 0))

for catpkg in "${INSTALLED[@]}"
do
	echo "EAPI="0"   $catpkg"
done

INSTALLED=( $(EIX_LIMIT=0 eix --installed --in-overlay 0 --only-names --installed-eapi 2))

for catpkg in "${INSTALLED[@]}"
do
        echo "EAPI="2"   $catpkg"
done

INSTALLED=( $(EIX_LIMIT=0 eix --installed --in-overlay 0 --only-names --installed-eapi 3))

for catpkg in "${INSTALLED[@]}"
do
        echo "EAPI="3"   $catpkg"
done
