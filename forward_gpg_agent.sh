#!/bin/bash -e

GPG_SOCK=$(echo "$GPG_AGENT_INFO" | cut -d: -f1)
if [ -z "$GPG_SOCK" ] ; then
    echo "No GPG agent configured - this won't work out." >&2
    exit 1
fi

vagrant ssh htc-build -- rm -f /home/vagrant/.gnupg/S.gpg-agent
vagrant ssh htc-build -- -t \
    -R /home/vagrant/.gnupg/S.gpg-agent:$GPG_SOCK \
    -o StreamLocalBindUnlink=yes \
    -o ExitOnForwardFailure=yes
