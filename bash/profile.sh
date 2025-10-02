set -x

src=.profile
dst="$HOME/.profile"

diff -u $src $dst > .profile.patch

cat .profile.patch

cp -v $src $dst

