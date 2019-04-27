#!/bin/sh

#  fabric.sh
#  ScrumPoker
#
#  Created by Rogelio Kobashi on 2019/04/27.
#  Copyright © 2019 rgkobashi. All rights reserved.

FABRIC_APIKEY_FILE="${SRCROOT}/Secrets/fabric.apikey"
FABRIC_BUILDSECRET_FILE="${SRCROOT}/Secrets/fabric.buildsecret"

if test ! -f "$FABRIC_APIKEY_FILE"; then
    echo "Fabric API key file missing:"
    echo " $FABRIC_APIKEY_FILE"
    exit 1
fi

if test ! -f "$FABRIC_BUILDSECRET_FILE"; then
    echo "Fabric build secret file missing:"
    echo " $FABRIC_BUILDSECRET_FILE"
    exit 1
fi

FABRIC_APIKEY=$(cat "$FABRIC_APIKEY_FILE")
if test $? -ne 0; then
    echo "Unable to read $FABRIC_APIKEY_FILE"
    exit 1
fi

FABRIC_BUILDSECRET=$(cat "$FABRIC_BUILDSECRET_FILE")
if test $? -ne 0; then
    echo "Unable to read $FABRIC_BUILDSECRET_FILE"
    exit 1
fi

"${PODS_ROOT}/Fabric/run" "$FABRIC_APIKEY" "$FABRIC_BUILDSECRET"
