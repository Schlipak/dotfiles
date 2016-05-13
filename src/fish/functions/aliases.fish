alias ll        'ls -l'
alias la        'ls -la'
alias l         'ls -alX'
alias j         'jobs'
alias emacs     'emacs -nw'
alias ne        'emacs'
alias sne       'sudo emacs -nw'
alias tne       'tclean; ne'
alias xman      'man -Hchromium'
alias rs        'reset'
alias vg        'valgrind'
alias vgl       'vg --leak-check=full --track-origins=yes'
alias gccw      'gcc -W -Wall -Werror -Wextra -std=gnu99'
alias gppw      'g++ -W -Wall -Werror -Wextra'
alias clangw    'clang -W -Wall -Werror -Wextra'
alias debug     'c; c; clangw -c *.cpp; rm -f *.o'
alias tree      'tree -C'
alias ocaml     'rlwrap ocaml'
