#!/bin/sh

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts

# DEFAULT IP FOR HOSTNAME
IP="127.0.0.1"

# Hostname to add/remove.
HOSTLINE=$2

echo "+$1+$HOSTLINE+"

removeline() {
  if [ -n "$(grep -E "^$HOSTLINE$" $ETC_HOSTS)" ]; then
    echo "$HOSTLINE Found in your $ETC_HOSTS, Removing now...";
    sudo sed -i '' "/^$HOSTLINE/d" $ETC_HOSTS
  else
    echo "$HOSTLINE was not found in your $ETC_HOSTS"
  fi
}

addline() {
  if [ -n "$(grep -E "^$HOSTLINE$" $ETC_HOSTS)" ]; then
    echo "$HOSTLINE Found in your $ETC_HOSTS, Removing now...";
  else
    echo "$HOSTLINE was not found in your $ETC_HOSTS, Adding now...";
    sudo -- sh -c -e "echo '$HOSTLINE' >> /etc/hosts";

    if [ -n "$(grep -E "^$HOSTLINE$" $ETC_HOSTS)" ]; then
      echo "$HOSTLINE was added successfully";
    else
      echo "Failed to Add $HOSTLINE, Try again!"
    fi

  fi
}

$1
