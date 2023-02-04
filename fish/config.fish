# *** PATHS ***
#
# Local bin
set -x LOCAL_BIN $HOME/.local/bin

# Node
set -x npm_config_prefix $HOME/.local

# Golang
# set -x GOROOT /usr/local/go
set -x GOROOT /usr/lib/go
set -x GOPATH $HOME/Developer/go
set -x GOBIN $HOME/Developer/go/bin

# Rust -> Cargo
set -x CARGOPATH $HOME/.cargo/bin

# NGiNX
set -x NGINXPATH /usr/local/nginx/sbin

# Java
set -x JAVA_HOME /usr/lib/jvm/default

# Android
# set -x ANDROID_SDK_ROOT /home/nils/Downloads/setups/android/sdk
set -x ANDROID_HOME /home/nils/Downloads/setups/android/sdk

# Append paths
# set PATH $PATH $LOCAL_BIN $GOROOT/bin $GOBIN $CARGOPATH $NGINXPATH $ANDROID_SDK_ROOT/cmdline-tools/latest/bin $ANDROID_SDK_ROOT/cmdline-tools/tools/bin
set PATH $PATH $LOCAL_BIN $GOROOT/bin $GOBIN $CARGOPATH $NGINXPATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools


# *** VARIABLES ***
#
# EDITOR
set -x EDITOR nvim

# Kvantum theme for Qt5 apps
# set -x QT_STYLE_OVERRIDE kvantum
# Qt5 applications under non-KDE environments, faking KDE environment
set -x XDG_CURRENT_DESKTOP KDE

# SXHKD 
# If using X window managers,
# Set default shell for 'sxhkd' as 'sh'
# set -U SXHKD_SHELL sh


# SSH-AGENT
#
if test -z (pgrep ssh-agent)
  ssh-agent -c > $HOME/.ssh-agent
  chmod 600 $HOME/.ssh-agent
end
source $HOME/.ssh-agent > /dev/null


# FZF
#
# By default hidden files are not included in fd search.
# To include hidden files in search (excluding .git, node_modules and some...)
#   use -H / --hidden flag (for including hidden files),
#   along with -E / --exclude flag (for exluding files and dirs)
# Although here files and dirs are excluded using ~/.fdignore file
set fzf_default_command 'fd --type file --type directory --strip-cwd-prefix'
set fzf_alt_c_command 'fd --type directory --strip-cwd-prefix'
set -x FZF_DEFAULT_COMMAND $fzf_default_command
set -x FZF_CTRL_T_COMMAND $fzf_default_command
set -x FZF_ALT_C_COMMAND $fzf_alt_c_command


# ALIAS
#
# always open emacs without window (i.e. in terminal)
alias emacs "emacs -nw"

# list files in descending order of ctime
alias la "ls -cltra"

# list files in ascending order of name
alias ll "ls -cl"

# change to dotfiles directory
alias dod "cd ~/Developer/dotfiles/"
# change to go directory
alias god "cd ~/Developer/go/src/"
# change to lua directory
alias lud "cd ~/Developer/lua/"
# change to node directory
alias nod "cd ~/Developer/node/"
# change to python directory
alias pyd "cd ~/Developer/python/"
# change to vue directory
alias vud "cd ~/Developer/vue/"

# python3 to py
alias py "python3"

# lxappearance
alias lx lxappearance

# open file in chromium incognito
alias web "chromium --incognito"


# FUNCTIONS
#
# swap files
function swap
	set TMPFILE "tmp"
	mv $argv[1] $TMPFILE && mv $argv[2] $argv[1] && mv $TMPFILE $argv[2]
end
# make directory and change into it
function mkdirt
    mkdir $argv[1] && cd $argv[1]
end
# print length of the given string
function len
    string length $argv[1]
end


# STARSHIP
#
# init script
starship init fish | source
