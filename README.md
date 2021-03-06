## Installation

`curl https://raw.github.com/harbu/vim-settings/master/install.sh | sh`

## Shortcuts

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
    <c-_>            auto-close nearest command in LaTeX

## Updating

`./update.sh`


## Adding a new submodule (plugin)

To add a submodule use the following command replacing <URL> and <NAME> with
the appropriate values:

    git submodule add <URL> bundle/<NAME>

## Removing a submodule (plugin)

    git submodule deinit bundle/<NAME>
    git rm bundle/<NAME>
