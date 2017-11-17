#!/bin/sh

# build.sh
# @author Seong Yong-ju ( @sei40kr )

cat <<EOM
==> Checking Docker and Docker Compose are set up correctly ...

EOM

if ! command -v docker 1>/dev/null
then
  cat 1>&2 <<EOM
  Error: Docker is not installed.

EOM
  exit 1
fi

if ! command -v docker-compose 1>/dev/null
then
  cat 1>&2 <<EOM
  Error: Docker Compose is not installed.

EOM
  exit 1
fi

if ! groups "$USER" | grep -qe '\bdocker\b'
then
  cat 1>&2 <<EOM
  Error: You should be a member of group \`docker\`. To resolve this, run this:

    sudo usermod -aG docker "\${USERNAME}"

EOM
  exit 1
fi

cat <<EOM
  Everything looks fine!

EOM

cat 1>&2 <<EOM
==> Running \`docker-compose -f docker-compose-dev.yml up\`

EOM

env \
  TERM=xterm \
  docker-compose -f docker-compose-dev.yml up

