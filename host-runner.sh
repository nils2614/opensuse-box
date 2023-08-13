#!/bin/sh

set -o errexit
set -o nounset

executable="$(basename "$0")"
parameters="${@}"
exec flatpak-spawn --host --watch-bus --forward-fd=1 --forward-fd=2 --directory="$(pwd)" --env=TERM=xterm-256color $executable $parameters