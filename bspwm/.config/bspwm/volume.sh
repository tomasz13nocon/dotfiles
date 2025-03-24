#!/bin/bash

download_album_art = true

function get_album_art {
    url=$(playerctl -f "{{mpris:artUrl}}" metadata)
    if [[ $url == "file://"* ]]; then
        album_art="${url/file:\/\//}"
    elif [[ $url == "http://"* ]] && [[ $download_album_art == "true" ]]; then
        # Identify filename from URL
        filename="$(echo $url | sed "s/.*\///")"

        # Download file to /tmp if it doesn't exist
        if [ ! -f "/tmp/$filename" ]; then
            wget -O "/tmp/$filename" "$url"
        fi

        album_art="/tmp/$filename"
    else
        album_art=""
    fi
}

song_title=$(playerctl -f "{{title}}" metadata)
song_artist=$(playerctl -f "{{artist}}" metadata)
song_album=$(playerctl -f "{{album}}" metadata)

get_album_art

volume=`amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1`
# bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
# dunstify -i audio-volume-high-symbolic -h int:value:$volume -h string:x-dunst-stack-tag:volume_control "$volume"
dunstify -i "$album_art" -h int:value:$volume -h string:x-dunst-stack-tag:volume_control  "$song_title" "$song_artist$([[ -n $song_album ]] && echo ' - ')$song_album"
