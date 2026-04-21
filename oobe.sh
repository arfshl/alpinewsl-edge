#!/bin/bash

set -ue

#DEFAULT_GROUPS='adm,cdrom,sudo,dip,plugdev'
DEFAULT_UID='1000'

echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new UNIX username: ' username

  # Create the user
  if /usr/sbin/adduser --uid "$DEFAULT_UID" --gecos ''  "$username"; then

    if /usr/sbin/addgroup "$username" wheel; then
      break
    else
      /usr/sbin/deluser "$username"
    fi
  fi
done

cat > /etc/sudoers.d/wsluser << EOF
# Ensure the WSL initial user can use sudo without a password.	
#
# Since the user is in the wheel group, this file can be removed
# if you wish to require a password for sudo. Be sure to set a
# user password before doing so with 'sudo passwd $username'!
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

echo 'Your user has been created, is included in the wheel group, and can use sudo without a password.'	
echo "To set a password for your user, run 'sudo passwd $username'"