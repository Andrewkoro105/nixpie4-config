#!/bin/sh

sudo git add .
sudo nixos-rebuild test --flake /etc/nixos/
