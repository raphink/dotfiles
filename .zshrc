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
export PATH=$PATH:/usr/local/go/bin:~/bin:~/.krew/bin
export GOPATH=$HOME

# Path to your oh-my-zsh installation.
export ZSH="/home/raphink/.oh-my-zsh"

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
  git git-auto-fetch
  golang
  ruby bundler gem rake
  docker docker-compose
  kubectl helm
)
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source /etc/bash_completion.d/azure-cli

source $ZSH/oh-my-zsh.sh

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

# default printer
export PRINTER=HP-Color-LaserJet-CM3530-MFP

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

alias d='docker'
alias t='terraform'
alias be='bundle exec'
alias s='summon'
compdef summon=sudo

alias l='lsd'
alias la='lsd -a'
alias ll='lsd -lah'
alias ls='lsd --color=auto'


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

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma-continuum/zsh-diff-so-fancy

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
alias ls='ls --color=auto'

#zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
#    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
#    pick"direnv" src="zhook.zsh"
#zinit load direnv/direnv

zinit ice from"gh-r" as"program" bpick"yq_linux_amd64.tar.gz" mv"yq_linux_amd64 -> yq"
zinit load mikefarah/yq

zinit ice from"gh-r" as"program"
zinit load simulot/aspiratv

zinit ice from"gh-r" ver"v2.1.0" as"program" mv"argocd-linux-amd64 -> argocd"
zinit load argoproj/argo-cd

zinit ice from"gh-r" as"program"
zinit load cyberark/summon

zinit ice from"gh-r" as"program" pick"usr/local/bin/sops"
zinit load mozilla/sops

zinit ice from"gh-r" ver"v1.11.0" as"program" bpick"*-linux-amd64.tar.gz" \
    pick"gopass-*/gopass"
    #atclone"./gopass completion zsh > _gopass" atpull'%atclone' \
zinit load gopasspw/gopass

#zinit id-as"openshift-client" as"monitor|command" extract \
#	dlink0'!%VERSION%~%(unreleased|stable.*|latest.*|fast.*|candidate.*|.*-rc.1|.*-rc.2|.*-rc.3|.*-rc.4)%' \
#    dlink"openshift-client-linux-%VERSION%.tar.gz" for \
#        https://mirror.openshift.com/pub/openshift-v4/clients/ocp/
#

zinit ice lucid wait'1' id-as'kubectl' as"null" sbin"kubectl"
#zinit snippet https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
# https://github.com/aws/aws-cli/issues/6920
zinit snippet https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl

zinit ice from"gh-r" as"program" bpick"k9s_Linux_x86_64.tar.gz"
zinit load derailed/k9s

zinit ice from"gh-r" as"program"
zinit load imhotepio/k9salpha

zinit ice from"gh-r" as"program" mv"k3d-linux-amd64 -> k3d"
zinit load k3d-io/k3d

zinit ice from"gh-r" as"program"
zinit load kubernetes-sigs/kustomize

zinit ice from"gh-r" as"program" mv"Zettlr-1.8.7-x86_64.AppImage -> zettlr"
zinit load Zettlr/Zettlr

#zinit id-as"helm" as="readurl|command" extract \
#        pick"linux-amd64/helm" \
#        dlink"https://get.helm.sh/helm-v%VERSION%-linux-amd64.tar.gz" \
#        for https://github.com/helm/helm/releases/
        #atload"helm plugin install https://github.com/databus23/helm-diff" \

zinit ice from"gh-r" as"program" mv"helmfile_linux_amd64 -> helmfile"
zinit load roboll/helmfile

#zinit id-as=terraform as='monitor|command' extract \
#    dlink0='/terraform/%VERSION%/' \
#    dlink='/terraform/%VERSION%/terraform_%VERSION%_linux_amd64.zip' \
#    for \
#        http://releases.hashicorp.com/terraform/

zinit ice from"gh-r" as"program"
zinit load alecthomas/chroma

# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice as"command" from"gh-r" mv"procs* -> procs" pick"usr/bin/procs"
zinit light dalance/procs

zinit ice as"command" from"gh-r" mv"sd* -> sd" pick"sd/sd"
zinit light chmln/sd

zinit ice from"gh-r" as"program" mv"fx-linux -> fx"
zinit load antonmedv/fx

zinit ice from"gh-r" as"program"
zinit load andreazorzetto/yh

zinit ice from"gh-r" as"program"
zinit load mikefarah/yq

zinit ice from"gh-r" as"program" bpick"youtube-dl"
zinit load ytdl-org/youtube-dl

zinit ice from"gh-r" as"program" pick"bin/dog"
zinit load ogham/dog

zinit ice from"gh-r" as"program" pick"usr/local/bin/bin/glab"
zinit load profclems/glab

zinit ice from"gh-r" as"program" pick"usr/bin/gh"
zinit load cli/cli

zinit ice from"gh-r" as"program" pick"usr/local/bin/exo"
zinit load exoscale/cli

zinit ice from"gh-r" as"program" mv"terraform-docs-v*-linux-amd64 -> terraform-docs"
zinit load terraform-docs/terraform-docs

zinit ice from"gh-r" as"program" pick"usr/local/bin/helm-docs"
zinit load norwoodj/helm-docs

zinit ice from"gh-r" as"program" bpick"lsd-*-x86_64-unknown-linux-gnu.tar.gz" \
  mv"lsd-*-x86_64-unknown-linux-gnu -> lsd" pick"lsd/lsd"
zinit load Peltoche/lsd

zinit ice from"gh-r" as"program" bpick"krew-linux_amd64.tar.gz" \
  mv"krew-linux_amd64 -> krew" pick"krew"
zinit load kubernetes-sigs/krew 

#zinit ice from"gh-r" as"program"
#zinit load jrhouston/tfk8s

zinit ice from"gh-r" as"program"
zinit load gomatic/renderizer

zinit ice from"gh-r" as"program" mv"opa_linux_amd64 -> opa"
zinit load open-policy-agent/opa

zinit ice from"gh-r" as"program" mv"kind-linux-amd64 -> kind"
zinit load kubernetes-sigs/kind

zinit ice from"gh-r" as"program"
zinit load nektos/act

zinit ice from"gh-r" as"program"
zinit load goreleaser/goreleaser

zinit ice from"gh-r" as"program"
zinit load cilium/cilium-cli

zinit ice from"gh-r" as"program"
zinit load cilium/hubble

zinit ice from"gh-r" as"program"
zinit load cilium/tetragon

zinit ice from"gh-r" as"program"
zinit load instruqt/cli

zinit ice from"gh-r" as"program"
zinit load hashicorp/packer

zinit ice from"gh-r" as"program" mv"rke_linux-amd64 -> rke"
zinit load rancher/rke

zinit ice from"gh-r" as"program"
zinit load juruen/rmapi

zinit ice from"gh-r" as"program"
zinit load httpie/httpie

zinit ice from"gh-r" as"program" bpick"*_linux_x86_64.tar.gz"
zinit load charmbracelet/glow

zinit ice from"gh-r" as"program" \
  bpick"cfssl_*_linux_amd64" mv"cfssl_*_linux_amd64 -> cfssl"
zinit load cloudflare/cfssl

#zinit ice from"gh-r" as"program" \
#  bpick"cfssljson_*_linux_amd64" mv"cfssljson_*_linux_amd64 -> cfssljson" \
#zinit load cloudflare/cfssl


# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit ice atinit'zicompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

# Gems
zinit ice gem'!jgrep'
zinit ice gem'!github_changelog_generator'
zinit ice gem'!travis'
zinit load zdharma-continuum/null


# Zfz
zinit pack"default+keys" for fzf



function sysdump-kas() {
  docker run --rm -v "$(readlink -f ${1}):/sysdump:ro" -p 8080:8080 quay.io/isovalent-dev/sysdump-kas:latest
}

function sysdump-k9s() {
  docker run --rm -v "$(readlink -f ${1}):/sysdump:ro" -ti quay.io/isovalent-dev/sysdump-kas:k9s
}

# Rust
source $HOME/.cargo/env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
