
#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PLATFORM=$(uname | tr "[:upper:]" "[:lower:]")

export ANDROID_SDK_VERSION=r22.3
export ANDROID_SDK_API_LEVEL=16
export ANDROID_HOME=${current_directory}/aaa

export ANDROID_NDK_VERSION=r9b
export ANDROID_NDK_API_LEVEL=16
export ANDROID_NDK=${current_directory}/android-ndk-${ANDROID_NDK_VERSION}

