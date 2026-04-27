#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Ошибка: требуется ровно один аргумент" >&2
    exit 1
fi

profile="$(cat /etc/nixos/counter)-$1"
echo "$profile"

new_value=$(( $(cat /etc/nixos/counter) + 1 ))
echo "$new_value" | sudo tee /etc/nixos/counter > /dev/null

commit_msg="$1"

git add .
sudo nixos-rebuild switch --flake /etc/nixos/ -p "$profile"
git commit -m "$commit_msg"
git push
