# *** PATHS ***
#
# Local bin
set -x LOCAL_BIN $HOME/.local/bin

# Node
set -x npm_config_prefix $HOME/.local

# Golang
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/Developer/go
set -x GOBIN $HOME/Developer/go/bin

# Rust -> Cargo
set -x CARGOPATH $HOME/.cargo/bin

# NGiNX
set -x NGINXPATH /usr/local/nginx/sbin

# Java
set -x JAVA_HOME /usr/lib/jvm/default

# Android
set -x ANDROID_SDK_ROOT /home/nix/Downloads/setups/android/sdk

# Append paths
set PATH $PATH $LOCAL_BIN $GOROOT/bin $GOBIN $CARGOPATH $NGINXPATH $ANDROID_SDK_ROOT/cmdline-tools/latest/bin $ANDROID_SDK_ROOT/cmdline-tools/tools/bin


# SXHKD 
# If using X window managers,
# Set default shell for 'sxhkd' as 'sh'
set -U SXHKD_SHELL sh


# FZF
#
# Include hidden files in search (excluding .git, node_modules and some...)
# set -x FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'
set fzf_default_command 'fd --type file --type directory --strip-cwd-prefix --hidden'
set fzf_alt_c_command 'fd --type directory --strip-cwd-prefix --hidden'
set -x FZF_DEFAULT_COMMAND $fzf_default_command
set -x FZF_CTRL_T_COMMAND $fzf_default_command
set -x FZF_ALT_C_COMMAND $fzf_alt_c_command


# SSH-AGENT
#
# if test -z (pgrep ssh-agent)
#   eval (ssh-agent -c)
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
# end


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

# python3 to py... I'm lazy
alias py "python3"


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


# STARSHIP
#
# init script
starship init fish | source
