#!/bin/bash

while getopts "u:g:s:" opt; do
  case "$opt" in
    u)
      username="$OPTARG"
      ;;
    g)
      groupnames+=("$OPTARG")
      ;;
    s)
      shell="$OPTARG"
      ;;
    *)
      echo "Usage: $0 -u <username> -g <groupname1> -g <groupname2> -s <shell>"
      exit 1
      ;;
  esac
done

if [ -z "$username" ] || [ ${#groupnames[@]} -eq 0 ]; then
  echo "Username and at least one group are required."
  exit 1
fi

# Check if the user exists, and create it if not
if ! getent passwd "$username" >/dev/null; then
  sudo useradd -m -s "$shell" -G "${groupnames[@]}" "$username"
  echo "User $username created and added to groups: ${groupnames[@]}"
else
  echo "User $username already exists."
fi
