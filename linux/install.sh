#!/bin/sh
#https://github.com/eosrei/twemoji-color-font
echo "Blob Color Font installer for Linux\n"

# Check for Bitstream Vera
fc-list | grep "Bitstream Vera" > /dev/null
RETURN=$?
if [ $RETURN -ne 0 ];then
  echo "Bitstream Vera font family not found. Please install it:"
  echo "sudo apt-get install ttf-bitstream-vera"
  exit 1
fi
echo "NOTE: Changing default font family to Bitstream Vera"

# Stop on errors
set -e
# Set XDG_DATA_HOME to default if empty.
if [ -z "$XDG_DATA_HOME" ];then
  XDG_DATA_HOME=$HOME/.local/share
fi

# Remove font from old directory if exists (temporary backwards compat)
if [ -f $HOME/.fonts/BlobColorFont-SVG.ttf ];then
  echo "Removing the font from $HOME/.fonts"
  rm $HOME/.fonts/BlobColorFont-SVG.ttf
fi

# Create a user font directory
mkdir -p $XDG_DATA_HOME/fonts
echo "Installing the font in: $XDG_DATA_HOME/fonts/"
cp BlobColorFont-SVG.ttf $XDG_DATA_HOME/fonts/

# Create a font config directory
FONTCONFIG=$HOME/.config/fontconfig
mkdir -p $FONTCONFIG/conf.d/
# Check for an existing font config
if [ -f $FONTCONFIG/fonts.conf ];then
  # (temporary backwards compat)
  echo "Existing fonts.conf backed up to fonts.bak"
  cp $FONTCONFIG/fonts.conf $FONTCONFIG/fonts.bak
fi
# Install fonts.conf
cp fontconfig/56-blob-color.conf $FONTCONFIG/conf.d/

echo "Clearing font cache"
fc-cache -f

echo "Done!"
