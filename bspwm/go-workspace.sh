#!/bin/bash

# okular
okular '/home/nix/Documents/books/Go/Mihalis Tsoukalos - Mastering Go_ Harness the power of Go to build professional utilities and concurrent servers and services, 3rd Edition-Packt Publishing (2021).pdf' &
sleep .2

# kitty
bspc rule -a konsole -o split_ratio=0.36
konsole &

# typora
bspc node -f @parent
bspc rule -a Typora -o split_ratio=0.6
/usr/local/typora/Typora &
