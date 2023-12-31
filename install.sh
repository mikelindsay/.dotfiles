#!/bin/bash
echo "Building environment"
sudo apt-get install i3
sudo apt-get install stow
sudo apt-get install firefox
sudo apt-get install git

URL=git@github.com:mikelindsay/.dotfiles.git
FOLDER=~/.dotfiles
STARTINGFOLDER=$PWD
if [ ! -d "$FOLDER" ] ; then
    git clone $URL $FOLDER
else
    cd "$FOLDER"
    git pull $URL
fi

# Create symbolic links
for file in ~/.dotfiles/.*; do
    basename=$(basename "$file")
    target="$HOME/$basename"

    # Exclude specific filenames
    if [[ $basename != "." && $basename != ".." && $basename != ".git" && $basename != ".gitignore" ]]; then
        # Check if a symbolic link already exists
        if [ -L "$target" ]; then
            echo "Symbolic link for $target already exists. Skipping."
        else
            # If a regular file exists with the same name, remove it
            if [ -f "$target" ]; then
                echo "Removing existing file: $target"
                rm "$target"
            fi

            # Create a symbolic link
            echo "Creating symbolic link for $file"
            ln -s "$file" "$target"
        fi
    fi
done
