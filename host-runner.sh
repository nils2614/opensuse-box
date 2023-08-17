#!/bin/sh
set -o errexit
set -o nounset

parameters="${@}" # Get parameters the script is called with
myname="$(basename "$0")" # Get name the script is called by
executable="${myname%-host}" # Ignore -host suffix in basename

exec /usr/bin/host-spawn $executable $parameters
