#!/usr/bin/env bash
#1. folder to organise: current folder or first argument if none given.

target_dir="${1:-.}"

#2. if folder doesn't exist print an error with stderr and exit with status 1

if [[ ! -d "$target_dir" ]] ; then
    echo "Error: Directory '$target_dir' doesn't exist." >&2
fi
#3. Loop over the files with for f in "$folder"/*, skip anything that isn't a file, and just print each name and its lowercase extension.
# Don't move anything yet.

for f in "$target_dir"/*; do
    if [ -f "$f" ]; then
        filename=$(basename "$f")

#extract extention convert it into lowercase
    ext="${filename##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        if [ "$filename" = "$ext" ] ; then
        ext=""
        fi

#categorizing each file according to their extensions
case "$ext" in
    jpg|jpeg|png|gif|webp)
        category="image"
        ;;
    pdf|doc|docx|txt|xlsx|pptx)
        category="Documents"
        ;;
    mp3|wav|m4a)
        category="Audio"
        ;;
    mp4|mkv|mov)
        category="video"
        ;;
    zip|rar|tar|gz)
        category="Archives"
        ;;
    *)
        category="other"
        ;;
esac                        

echo "$filename = $category/"

    fi

done