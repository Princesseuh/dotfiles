#!/bin/sh

icon="<span size='xx-large' rise='-2100'></span>"

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ] && [ "$updates" -lt 2 ]; then
    echo "$icon <b>$updates</b> uppdatering tillgänglig"
elif [ "$updates" -gt 1 ]; then
    echo "$icon <b>$updates</b> uppdateringar tillgängliga"
else
    echo "$icon"
fi
