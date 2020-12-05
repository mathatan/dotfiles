export CLICOLOR=1
# use yellow for directories
export LSCOLORS=dxfxcxdxbxegedabagacad

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_NDK_HOME=${ANDROID_HOME}/ndk-bundle

export PATH=/usr/local/bin:/usr/local/sbin:${PATH}
export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${HOME}/ngrok
export PATH=${PATH}:${HOME}/scripts

# unalias du
alias cdcode="cd ~/Documents/Personal/Code"

export RUBY_HOME=/usr/local/opt/ruby/bin
export PATH=$RUBY_HOME:$PATH
export RBENV_ROOT="$(brew --prefix rbenv)"
export GEM_HOME="$(brew --prefix)/opt/gems"
export GEM_PATH="$(brew --prefix)/opt/gems"
export PATH=$GEM_PATH/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
