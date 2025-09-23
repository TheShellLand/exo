set -x

src=.profile
dst="$HOME/.profile"

diff -u $src $dst 

cp -v $src $dst

