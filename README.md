##INSTALLATION

Download the `install.sh` file, chmod it to executable, and finally run it.

##COMMANDS

|F2            |   bring up nerdtree file browser                        |
|F3            |   toggle spell checking                                 |
|F4            |   toggle highlighting of trailing whitespace            |
|F5            |   strip all trailing whitespaces                        |
|<c-p>         |   bring up fuzzy file search                            |
|<Leader> + l  |   toggle display of tabs and end-of-lines as characters |
|<S-h>         |   cycle through tabs                                    |
|<S-l>         |                                                         |
|:%!xxd        |   switch on hex mode                                    |
|:%!xxd -r     |   exit from hex mode                                    |
|å             |   ergonomic alternative for <ESC>                       |
|:DiffOrig     |   diff file on disk and current buffer                  |
|\\\           |   toggle commenting out lines of code                   |




##UPDATE

    git pull
    git submodule foreach git checkout master
    git submodule foreach git pull


##ADDING A SUBMODULE

To add a submodule use the following command replacing <URL> and <NAME> with
the appropriate values:

    git submodule add <URL> bundle/<NAME>
