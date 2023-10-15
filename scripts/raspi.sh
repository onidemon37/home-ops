#!/usr/bin/env bash
# File      : raspi.sh
# Created   : <2023-06-07 Wed 19:24:00 GMT>
# Modified  : <2023-06-07 Tue 19:24:00 GMT>
# Limb      : home-ops

set -euo pipefail

# NOTE: Run as root, as it is requiered for image_write()

if [ "${BASH_VERSIONINFO[0]}" -lt "4" ]
then
    echo "Bash 4 or higher is required to proceed. Exit"
    exit 1
fi

SCRIPT_NAME="raspi.sh"
SCRIPT_VERSION="0.1.0"

DEBUG=${DEBUG:-0}
[ $DEBUG -eq 1 ] && set -x

PASS=$'[]'
FAIL=$'[]'
INFO="[ INFO ]"

REQUIRE=(

)

URL_DAILY=""
URL_VERIFIED=""
RASPI_MODEL="${RASPI_MODEL:-3}"

# -------------------------------------------------------------------------------

_err()
{
    # All errors go to stderr
    printf ""
    exit 1
}
