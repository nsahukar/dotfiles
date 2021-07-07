# *** PATHS ***
#
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

# Append paths
set PATH $PATH $GOROOT/bin $GOBIN $CARGOPATH $NGINXPATH


# FZF
#
# Include hidden files in search (excluding some)
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'


# SSH-AGENT
#
# if test -z (pgrep ssh-agent)
#   eval (ssh-agent -c)
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
# end
