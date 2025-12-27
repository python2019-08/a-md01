#!/bin/bash
# Check for LD_LIBRARY_PATH being set, which can break SDK and generally is a bad practice
# Only disable this check if you are absolutely know what you are doing!
if [ ! -z "$LD_LIBRARY_PATH" ]; then
    echo "Your environment is misconfigured, you probably need to 'unset LD_LIBRARY_PATH'"
    echo "but please check why this was set in the first place and that it's safe to unset."
    echo "The SDK will not operate correctly in most cases when LD_LIBRARY_PATH is set."
    return 1
fi
export SDKTARGETSYSROOT=/opt/ndk27d/sysroots/aarch64-android 
export CORE_TARGET_SYSROOT="$SDKTARGETSYSROOT"
 
# Append environment subscripts
if [ -d "$CORE_TARGET_SYSROOT/environment-setup.d" ]; then
    for envfile in $CORE_TARGET_SYSROOT/environment-setup.d/*.sh; do
	    . $envfile
    done
fi 