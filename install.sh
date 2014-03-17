#!/bin/bash

# Clone repo
git clone git@github.com:harbu/vim-settings.git ~/.vim

# Create symlinks.
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Fetch submodules
git --work-tree ~/.vim submodule init
git --work-tree ~/.vim submodule update

# Add symbolic links for xmledit so that it works on HTML and GSP files.
ln -s ~/.vim/bundle/xmledit/ftplugin/xml.vim ~/.vim/bundle/xmledit/ftplugin/html.vim
ln -s ~/.vim/bundle/xmledit/ftplugin/xml.vim ~/.vim/bundle/xmledit/ftplugin/gsp.vim

# Create a folder for temporary backup files.
mkdir ~/.vim_tmp
