#!/bin/bash

# 1. Clone repo
git clone git@github.com:harbu/vim-settings.git

# 2. Move it to home directory and rename to .vim/
mv vim-settings/ ~
mv vim-settings/ .vim/

# 3. Create symlinks.
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# 4. Switch to the ~/.vim directory, and fetch submodules.
cd ~/.vim
git submodule init
git submodule update

# 5. Add a symbolic link to xmledit-plugin directory so that it works on HTML
#    and GSP files.
cd ~/.vim/bundle/xmledit/ftplugin/
ln -s xml.vim html.vim
ln -s xml.vim gsp.vim

# 6. Create a folder for temporary backup files.
mkdir ~/.vim_tmp

echo "Installation done."
