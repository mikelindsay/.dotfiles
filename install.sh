#!/bin/bash
echo "Building environment"
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get --yes --force-yes install i3
sudo apt-get --yes --force-yes install stow
sudo apt-get --yes --force-yes install firefox
sudo apt-get --yes --force-yes install git
sudo apt-get --yes --force-yes install neovim

URL=git@github.com:mikelindsay/.dotfiles.git
FOLDER=~/.dotfiles
STARTINGFOLDER=$PWD
if [ ! -d "$FOLDER" ] ; then
    git clone $URL $FOLDER
else
    cd "$FOLDER"
    git pull $URL
fi

# Function to create symbolic links
# Function to create symbolic links
create_symlink() {
    local file=$1
    local target=$2

    # Avoid creating a symlink if the target and source are the same
    if [[ "$file" -ef "$target" ]]; then
        echo "Skipping: Source and target are the same for $file"
        return
    fi

    # Check if the target is a symlink that points to the source
    if [[ -L "$target" && "$(readlink -f "$target")" == "$file" ]]; then
        echo "Skipping: $target is a symlink to $file"
        return
    fi

    # Check if a symbolic link already exists
    if [ -L "$target" ]; then
        echo "Symbolic link for $target already exists. Skipping."
        return
    fi

    # Get the basename of the target
    local target_basename=$(basename "$target")

    # Check if the target basename is in the exclude base folders list
    local exclude=false
    for excluded_folder in "${exclude_base_folders_to_remove[@]}"; do
        if [[ "$target_basename" == "$excluded_folder" ]]; then
            exclude=true
            break
        fi
    done

    # If a regular file or directory exists with the same name and it's not in the exclude list, remove it
    if [[ -e "$target" && "$exclude" == false ]]; then
        echo "Removing existing file: $target"
        rm -f -r "$target"
    fi

    # Create a symbolic link
    if [[ "$exclude" == false ]]; then
        echo "Creating symbolic link for $file to $target"
        ln -s "$file" "$target"
    fi
}

# Array of base folder names to exclude from removal
exclude_base_folders_to_remove=(".config")

# Array of filenames to exclude
exclude_files=(".git" ".gitignore" "." "..")

# Function to check if a file is in the exclude list
is_excluded() {
    local file=$1
    for excluded in "${exclude_files[@]}"; do
        if [[ $file == $excluded ]]; then
            return 0
        fi
    done
    return 1
}

# Create symbolic links for dotfiles in the home directory
for file in ~/.dotfiles/.*; do
    basename=$(basename "$file")
    target="$HOME/$basename"

    if ! is_excluded "$basename"; then
        create_symlink "$file" "$target"
    fi
done

# Create symbolic links for files in the .config directory
for file in ~/.dotfiles/.config/*; do
    basename=$(basename "$file")
    target="$HOME/.config/$basename"

    if ! is_excluded "$basename"; then
        create_symlink "$file" "$target"
    fi
done


# Vim (~/.vim/autoload)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim (~/.local/share/nvim/site/autoload)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
nvim +PlugInstall +qall
