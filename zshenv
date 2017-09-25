export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

export PATH="/usr/local/var/pyenv/shims:/Users/civisemployee/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin"
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
# export MANPATH="/usr/local/man:$MANPATH"

export PYENV_ROOT=/usr/local/var/pyenv

export VAGRANT_FORWARD_MYSQL_PORT=13306

# These commands change env vars
eval "$(rbenv init -)"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
. /Users/civisemployee/.nix-profile/etc/profile.d/nix.sh
