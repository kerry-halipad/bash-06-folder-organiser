#!/usr/bin/env bash
#1. folder to organise: current folder or first argument if none given.

folder="${1:-.}"

#2. if folder doesn't exist print an error with stderr and exit with status 1

if [[ ! -d "$folder" ]] ; then
    echo "Error: Directory '$folder' doesn't exist." >&2
fi

echo "organising $folder........."

move_count=0

#3. Loop over the files with for f in "$folder"/*, skip anything that isn't a file, and just print each name and its lowercase extension.
# Don't move anything yet.

for f in "$folder"/*; do
    if [ -f "$f" ]; then
        name=$(basename "$f")

#extract extention convert it into lowercase
    ext="${name##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        if [ "$name" = "$ext" ] ; then
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

mkdir -p "$folder/$category"

dest="$folder/$category/$name"

if [ -e "$dest" ]; then

    if [[ "$name" == *.* ]]; then
        base="${name%.*}"
        ext="${name##.}"
    else
        base="${name}"
        ext=""    
    fi

 

n=1
    while [ -e "$dest" ]; do
        if [ -z "$ext" ]; then
            dest="$folder/$category/${base}($n)"
        else    
            dest="$folder/$category/${base}($n).$ext"
        fi    
    ((n++))
    done
fi
#creating category folder when file moves into it

mv "$f" "$dest"

echo " $name move to $category/$(basename "$dest")"
((move_count++))
    fi   
done
    echo "Done: $move_count files moved"