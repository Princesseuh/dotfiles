#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon="<span size='xx-large' rise='-2100'></span>"

if [[ $class == "playing" ]] || [[ $class == "paused" ]]; then
  info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')

  # If the title is too long, cut it and add ellipsis
  if [[ ${#info} -ge 40 ]]; then
    info=$(echo -e $info | colrm 40)"..."
  fi

  # If we don't escape HTML, Waybar has problems showing the string even though the script technically work
  text=$icon" "$(echo -e $info | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
elif [[ $class == "stopped" ]]; then
  text="$icon"
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
