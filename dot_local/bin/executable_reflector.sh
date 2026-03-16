#!/bin/bash

sudo reflector --country US --latest 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist
