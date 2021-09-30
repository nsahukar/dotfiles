# HOMEBREW
set -x BREW_PATH /usr/local/sbin

# LLVM
set -x LLVM_PATH /usr/local/opt/llvm/bin

# Golang
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/Developer/go
set -x GOBIN $HOME/Developer/go/bin

# NGiNX
# set -x NGINXPATH /usr/local/nginx/sbin

# Java
# set -x JAVA_HOME /usr/lib/jvm/default

# FZF
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'

set PATH $PATH $BREW_PATH $LLVM_PATH $GOROOT/bin $GOBIN 
