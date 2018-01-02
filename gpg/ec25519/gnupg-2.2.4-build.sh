#!/bin/bash


log=install.log
if [ -f "$log" ]; then rm -f "$log"; fi

apt install -y bzip2 make gcc >>$log 2>>$log || exit 1 && \
echo -n "downloading source code"
for download in \
  "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.4.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.4.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.2.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.2.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/ntbtls/ntbtls-0.1.2.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/ntbtls/ntbtls-0.1.2.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/gpa/gpa-0.9.10.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/gpa/gpa-0.9.10.tar.bz2.sig" \
  "https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2" \
  "https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2.sig" \
  "ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-0.3.16.tar.gz" \
  "ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-0.3.16.tar.gz.sig"; do
    wget -q -N "$download" >>$log && echo -n "." || exit 1
done && \
echo -e "done"
echo -n "uncompressing"
for archive in $(ls); do
  if [ -f "$archive" ]; then
    if [[ "$archive" == *".bz2" ]]; then
      tar -jxf "$archive" >>$log || exit 1 && \
      echo -n "."
    fi
    if [[ "$archive" == *".gz" ]]; then
      tar -zxf "$archive" >>$log || exit 1 && \
      echo -n "."
    fi
  fi
done && \
echo -e "done"
#gpg --verify gnupg-2.2.4.tar.bz2.sig && \
#gpg --verify libgpg-error-1.27.tar.bz2.sig && \
#gpg --verify libgcrypt-1.8.2.tar.bz2.sig && \
#gpg --verify libksba-1.3.5.tar.bz2.sig && \
#gpg --verify libassuan-2.5.1.tar.bz2.sig && \
#gpg --verify ntbtls-0.1.2.tar.bz2.sig && \
#gpg --verify npth-1.5.tar.bz2.sig
apt install -y zlib1g-dev >>$log 2>>$log && echo "" || exit 1 && \
function build {
  for package in $(ls); do
    if [ -d "$package" ]; then
      if [[ "$package" == *"$1"* ]]; then
        cd "$package"
        log=../install.log
        echo -n "building $package"
        ./configure >>$log 2>>$log && echo -n "." || exit 1 && \
        make >>$log 2>>$log && echo -n "." || exit 1 && \
        make install >>$log 2>>$log && echo "done" || exit 1 && \
        cd ..
      fi
    fi
  done
}
apt install -y g++ libfltk1.3-dev >>$log 2>>$log || exit 1 && \
build libgpg-error || exit 1 && \
build libgcrypt || exit 1 && \
build libassuan || exit 1 && \
build libksba || exit 1 && \
build npth || exit 1 && \
#build ntbtls || exit 1 && \
build pinentry || exit 1 && \
#build gpgme || exit 1 && \
#build gpa || exit 1 && \
build gnupg || exit 1 && \
echo ""
echo -n "moving libraries"
mv /usr/local/lib/libgpg-error* /lib/x86_64-linux-gnu/ && echo -n "." && \
mv /usr/local/lib/libgcrypt* /lib/x86_64-linux-gnu/ && echo -n "." && \
mv /usr/local/lib/libassuan* /usr/lib/x86_64-linux-gnu/ && echo -n "." && \
mv /usr/local/lib/libnpth* /usr/lib/x86_64-linux-gnu/ && echo -n "."
echo "done"


echo "Done"
