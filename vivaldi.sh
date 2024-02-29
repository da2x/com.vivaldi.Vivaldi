#!/usr/bin/bash

case $(uname -m) in
  x86_64)
    FFMPEG_VERSION=114023
    if [ -e "$XDG_DATA_HOME/vivaldi-extra-libs/media-codecs-$FFMPEG_VERSION/libffmpeg.so" ]; then
      export ZYPAK_LD_PRELOAD="$ZYPAK_LD_PRELOAD${ZYPAK_LD_PRELOAD:+:}$XDG_DATA_HOME/vivaldi-extra-libs/media-codecs-$FFMPEG_VERSION/libffmpeg.so"
    else
      echo "'Proprietary media' support is not installed. Attempting to fix this for the next restart." >&2
      nohup "/app/vivaldi/update-ffmpeg" --user > /dev/null 2>&1 &
    fi
    ;;
  aarch64)
    export LIBGL_DRIVERS_PATH=/usr/lib/aarch64-linux-gnu/GL/lib/dri
    ;;
esac

export VIVALDI_FFMPEG_FOUND=YES # Prevents excessive warning for flatpak users

exec cobalt "$@" --no-default-browser-check
