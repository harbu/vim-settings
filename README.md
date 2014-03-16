###INSTALLATION

`curl https://raw.github.com/harbu/vim-settings/master/install.sh | sh`

###COMMANDS

F2               bring up nerdtree file browser
F3               toggle spell checking
F4               toggle highlighting of trailing whitespace
F5               strip all trailing whitespaces
<c-p>            bring up fuzzy file search
<Leader> + l     toggle display of tabs and end-of-lines as characters
<S-h>            cycle through tabs
<S-l>
:%!xxd           switch on hex mode
:%!xxd -r        exit from hex mode
å                ergonomic alternative for <ESC>
:DiffOrig        diff file on disk and current buffer
\\\              toggle commenting out lines of code




###UPDATE

`./update.sh`


###ADDING A SUBMODULE

To add a submodule use the following command replacing <URL> and <NAME> with
the appropriate values:

    git submodule add <URL> bundle/<NAME>
