set -x

src=.bashrc
dst="$HOME/$src"
patch=.bashrc.patch

diff -u $src $dst > $patch

cat $patch

cp -v $src $dst

