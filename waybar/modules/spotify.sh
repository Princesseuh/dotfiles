#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon="<span size='xx-large' rise='-2100'></span>"

if [[ $class == "playing" ]] || [[ $class == "paused" ]]; then
  info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
  if [[ ${#info} > 40 ]]; then
    info=$(echo -e $info | colrm 40)"..."
  fi
  text=$icon" "$info
elif [[ $class == "stopped" ]]; then
  text="$icon"
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
