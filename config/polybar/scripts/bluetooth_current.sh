#!/bin/bash

options="active|connected|devices|help"

blue_help() {
  HELP="Prints this help message"
  local fmt="%-5s%-15s%-25s\n"
  echo "Usage: ${BASH_SOURCE[0]} {$options}"
  IFS='|'
  for opt in $options; do
    local cmd=$(cut -f1 -d' ' <<<"$opt")
    local def=$(type blue_$cmd \
                | grep -m 1 "HELP" \
                | sed -e "s/HELP=[\"']\(.*\)[\"'].*/\1/g")

    printf "$fmt" " " "$opt" "$def"
  done
}

blue_active() {
  HELP="Prints *yes* if bluetooth is active, *no* otherwise"
  if bluetoothctl show | grep -q "Powered: yes"; then
    echo "yes"
    return 0
  else
    echo "no"
    return 1
  fi
}

blue_devices() {
  HELP="Prints list of devices connected and their battery information if any"

  local paired=$(bluetoothctl devices Paired | grep Device | awk '{ print $2 }')
  for device in $paired; do
    local info=$(bluetoothctl info "$device")

    local fmt="%-10s%s\n"
    if echo "$info" | grep -q "Connected: yes"; then
      local name=$(echo "$info" | grep "Alias" | cut -d' ' -f2-)

      local bluez_dev="/org/bluez/hci0/dev_${device//:/_}"

      local dbus_query="--print-reply=literal --system --dest=org.bluez \
                        $bluez_dev \
                        org.freedesktop.DBus.Properties.Get \
                        string:\"org.bluez.Battery1\" \
                        string:\"Percentage\"
                       "
      local batt_percentage="Unknown"
      local dbus_out=$(dbus-send $dbus_query 2>/dev/null)
      if [ -n "$dbus_out" ]; then
        batt_percentage=$(echo "$dbus_out" | awk '{ print $3 }' )
      fi

      printf "$fmt" "$name" "$batt_percentage"
      return 0
    fi
  done
}

blue_connected() {
  HELP="Prints *yes* if bluetooth is active and is connected to something, *no* otherwise"

  local paired=$(bluetoothctl devices Paired | grep Device | awk '{ print $2 }')
  local count=0

  for device in $paired; do
    local info=$(bluetoothctl info "$device")
    if echo "$info" | grep -q "Connected: yes"; then
      count=$((count + 1))
    fi
  done
  if (( $count > 0 )); then
    echo $count
    return 0
  fi
  echo $count
  return 1
}

cmd=$1
shift

if [[ -n $cmd ]] && [[ $options =~ $cmd ]]; then
  blue_$cmd "$@"
else
  blue_help
  exit 1
fi
