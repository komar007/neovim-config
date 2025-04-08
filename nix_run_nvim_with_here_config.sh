#!/bin/sh

DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

env "XDG_CONFIG_HOME=$DIR" nix run "$DIR" -- "$@"
