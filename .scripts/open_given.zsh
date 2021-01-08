#!/bin/zsh

# README: Script to open or focus given file with defined default opener, depending on the file extension. Recommended: use in combination with fzfOpenGuake.zsh -- fzfOpenGuake.zsh "open_given.zsh \$sel". Also used in guake quick open.

# file full path, filename and extension.
file="$1"
filename=${file##*\/}
filepath=${file%\/*}
extension=${filename##*\.}

# check if file param is empty
if [ -z $file ]
then
  exit
fi

# check if file param contains defined cases. 
# If yes, then do according to case.
case "$file" in
  */bin/*)
    $file &
    ;;
  *.R|*.Rmd)
    rstudio $file &
    ;;
  *.pdf)
    zathura $file &
    ;;
  *.mp3|*.mp4)
    mpv $file &
    ;;
  *.jpg|*.jpeg|*.png)
    $IMAGES $file &
    ;;
  *.py|*.hs|*.txt|*.csv|*.md|*.scala)
    $TERM -e "$EDITOR $file"&
    ;;
  *.*sh)
    if [ "$2" = "launch" ]
    then
      $SHELL $file &
    # elif [ "$2" = "edit" ]
    # then
    else
      $TERM -e "$EDITOR $file"&
    fi
    ;;
  *Bazecor*.AppImage)
    sudo chmod 666  /dev/ttyACM0; $file&
    ;;
  *.AppImage)
    $file&
    ;;
  */.*)
    $TERM -e "$EDITOR $file"&
    ;;
  *)
    $TERM -e "$EDITOR $file"&
    ;;
esac
