#!/usr/bin/env bash

rm -f ~/Makefile
curl -sSL https://raw.githubusercontent.com/jcrawleyjc/dotfiles/master/Makefile > ~/Makefile
make -C ~ install-homebrew
make -C ~ init
