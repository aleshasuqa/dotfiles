bindkey -e


# === fzf ===
fg="#D8CAAC"
bg="#1F1F28"
bg_highlight="#505A60"
purple="#D39BB6"
blue="#83B6AF"
cyan="#87C095"
grey="#868D80"

export FZF_DEFAULT_OPTS="--color=fg:-1,bg:-1,hl:${purple},fg+:${fg} \
                        --color=bg+:${bg_highlight},hl+:${purple},info:${blue} \
                        --color=prompt:${cyan},pointer:${cyan},marker:${cyan} \
                        --color=spinner:${cyan},header:${cyan},gutter:${bg} \
                        --padding=\"1\" \
                        --prompt=\"> \" \
                        --marker=\">\" \
                        --pointer=\"◆\" \
                        --separator=\"-\" \
                        --scrollbar=\"│\" \
                        --layout=\"reverse\" \
                        --info=\"right\""

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source "$HOME/fzf-git.sh"

# === useful stuff ===

mkjest() {
    touch "test/$1.test.js"
    echo "const { $1 } = require(\"../$1/$1\");

test('', () => {
  expect($1()).toBe();
});" > "test/$1.test.js"
}

gcom() {
    if [ "$1" = "" ]; then
        git commit -m "ff"
    else
        git commit -m "$1"
    fi
}

gccf() {
    gcc -std=c99 -pedantic -Werror -Wall -Wextra -Wvla -fsanitize=address -g -o "out" "$@"
}

gcpp() {
    g++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -o "out" "$@"
}

gtt() {
    echo "\n---commit---\n"
    git commit -m "gg"
    echo "\n---tag---\n"
    git tag -a "$1" -m "gg"
    echo "\n---push---\n"
    git push --follow-tags origin master
}

gacp() {
  echo "\n---add---\n"
  git add -u
  echo "\n---commit---\n"
  git commit -m "$1"
  echo "\n---push---\n"
  git push
}

gccl() {
    gccf $@
    lik "./out"
}

lik() {
    MallocStackLogging=YES leaks -q --atExit -- $1 > tmp
    clear
    cat tmp
    rm tmp
}

# === env vars ===
export ZSH="$HOME/.oh-my-zsh"
export PATH=/usr/local/bin:$PATH
export MAGICK_HOME=/opt/homebrew/opt/imagemagick/
export PATH="/opt/homebrew/opt/imagemagick/bin:$PATH"
# export PATH="/opt/homebrew/include:$PATH"
# export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/Cellar/ffmpeg/5.1.2_6/include:$PATH"
# export PATH="/opt/homebrew/include:${PATH:+:${PATH}}"
export PATH="/opt/homebrew/opt/clang-build-analyzer/bin:$PATH"
export PATH="/opt/homebrew/opt/cmake/bin:$PATH"
export PATH="/opt/homebrew/Cellar/clang-build-analyzer/1.5.0/bin:${PATH:+:${PATH}}"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPATH="/opt/homebrew/include"
export LIBRARY_PATH="/opt/homebrew/lib" 
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export BAT_THEME="kanagawa"

# === psql ===
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
mkdb() {
    initdb --locale "$LANG" -E UTF8
    postgres -k "$PGHOST"
    psql postgres -U "$USERNAME" -d postgres -f "$HOME/epita/js/epiTinderDB/provided.sql"
}

# === omz ===
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# === evals ===
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# === opam ===
[[ ! -r /Users/alekseikotliarov/.opam/opam-init/init.zsh ]] || source /Users/alekseikotliarov/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# === nvm ===
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# === aliases ===
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

alias ga="git add"
alias gp="git push"
alias gs="git status"

alias vim="nvim"
alias vi="nvim"
alias cim="nvim"

alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree -I node_modules'
