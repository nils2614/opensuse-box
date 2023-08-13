#!/bin/sh
set -o errexit
set -o nounset

parameters="${@}"
myname="$(basename "$0")"
executable="${myname%-host}" # Ignore -host suffix in application names

exec flatpak-spawn --host --watch-bus --directory="$(pwd)" --env=TERM=xterm-256color $executable $parameters
