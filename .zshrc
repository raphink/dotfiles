# Skip the not really helping Debian global compinit
skip_global_compinit=1

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:~/bin:~/.krew/bin:/opt/homebrew/bin:/Library/TeX/Distributions/TeXLive-2023.texdist/Contents/Programs/arm64
export GOPATH=$HOME

# Path to your oh-my-zsh installation.
#export ZSH="/home/raphink/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

#ENABLE_CORRECTION="true"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
BUNDLED_COMMANDS=(puppet-lint rake)
plugins=(
  aws
  colorize
  gpg-agent ssh-agent
  dirhistory
  git git-auto-fetch gh
  golang
  ruby bundler gem rake
  docker docker-compose
  kubectl helm
)
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Show PR number if branch has an open PR
function git_prompt_pr_number() {
  if command -v gh >/dev/null 2>&1; then
    pr=$(gh pr view --json number -q '.number' 2>/dev/null)
    [[ -n "$pr" ]] && echo "$pr"
  fi
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Force emacs mode for shell navigation (even with vim as editor)
bindkey -e

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias please='sudo $(history -p \!\!)'

alias t='terraform'
alias be='bundle exec'
alias s='summon'
compdef summon=sudo

alias l='lsd'
alias la='lsd -a'
alias ll='lsd -lah'
alias ls='lsd --color=auto'


## Useful variables for installs
platform="$(uname -s | tr '[:upper:]' '[:lower:]')"
architecture="$(uname -m)"
case $architecture in
  x86_64)
    arch="amd64"
    ;;
  arm64)
    architecture="aarch64"
    arch="arm64"
    ;;
esac

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

# ssh-agent add
zstyle :omz:plugins:ssh-agent identities id_rsa_perso

zstyle ':completion' menu select

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit light mafredri/zsh-async

zinit ice as"program" pick"bin/git-dsf"
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS
alias ls='ls --color=auto'

# Tools that remain in zinit (not available in Homebrew or need special handling)
zinit ice from"gh-r" as"program" pick"usr/local/bin/exo"
zinit load exoscale/cli

zinit ice from"gh-r" as"program"
zinit load juruen/rmapi

zinit ice from"gh-r" as"program" pick"usr/local/bin/helm-docs"
zinit load norwoodj/helm-docs

zinit ice from"gh-r" as"program" \
  bpick"talosctl-${platform}-${arch}" mv"talosctl-${platform}-${arch} -> talosctl"
zinit load siderolabs/talos

zinit ice from"gh-r" as"program" mv"rke_${platform}-${arch} -> rke"
zinit load rancher/rke

zinit ice from"gh-r" as"program"
zinit load "Netflix/bpftop"

# Keep summon in zinit since it's not available in Homebrew
zinit ice from"gh-r" as"program"
zinit load cyberark/summon

# Keep tetragon in zinit since it's not available in Homebrew
zinit ice from"gh-r" as"program"
zinit load cilium/tetragon

# Ruby Gems - keeping github_changelog_generator, removing jgrep and travis
zinit ice gem'!github_changelog_generator'
zinit load zdharma-continuum/null

function sysdump-kas() {
docker run --rm -v "$(readlink -f ${1}):/sysdump:ro" -p 8080:8080 quay.io/isovalent-dev/sysdump-kas:latest
}

function sysdump-k9s() {
  docker run --rm -v "$(readlink -f ${1}):/sysdump:ro" -p 8080:8080 -ti quay.io/isovalent-dev/sysdump-kas:k9s
}

# Rust
source $HOME/.cargo/env

# Instruqt
alias instruqt-dev=~/src/github.com/isovalent/instruqt/tracks/scripts/instruqt-dev.sh

# Kubecolor
alias kubectl=kubecolor
compdef kubecolor=kubectl

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh