export NODE_PATH=/usr/local/lib/jsctags/:/usr/local/lib/node_modules:$NODE_PATH
export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_NDK_HOME=${ANDROID_HOME}/ndk-bundle

#path, the 0 in the filename causes this to load first
path=(
  /usr/local/bin
  /usr/local/sbin
  /usr/local/mysql/bin  
  $path
  $HOME/.dotfilesbin
  ${ANDROID_HOME}/platform-tools
  ${ANDROID_HOME}/tools
  /usr/local/opt/node@8/bin
  # $HOME/.yadr/bin/yadr
)
