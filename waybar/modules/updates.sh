#!/bin/sh

no_updates_icon=""
updates_icon=""

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ] && [ "$updates" -lt 2 ]; then
    text="$updates_icon <b>$updates</b> uppdatering tillgänglig"
    echo -e "{\"text\":\""$text"\", \"class\":\"updates\"}"
elif [ "$updates" -gt 1 ]; then
    text="$updates_icon <b>$updates</b> uppdateringar tillgängliga"
    echo -e "{\"text\":\""$text"\", \"class\":\"updates\"}"
else
    text="$no_updates_icon inga uppdateringar"
    echo -e "{\"text\":\""$text"\", \"class\":\"no-updates\"}"
fi
