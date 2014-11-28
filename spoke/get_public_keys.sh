#!/bin/bash
set -e

# Import public keys from github
if [ ! $GH_USER = "" ]; then
    ssh-import-id --output /root/.ssh/authorized_keys gh:$GH_USER
fi

exit 0
