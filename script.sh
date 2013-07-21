#!/bin/bash
# Removing noises from some image by using Fourier Transforms on ImageMagick
# Caio SBA <caiosba@gmail.com>, 2013
# About Fourier Transforms on ImageMagick: http://www.imagemagick.org/Usage/fourier/
# About Fourier Transforms installation for Imagemagick: http://www.imagemagick.org/discourse-server/viewtopic.php?f=4&t=14251#p56836
dir=$(mktemp -d)
echo "Converting..."
/usr/local/bin/convert $1 "$dir/$1.png"
/usr/local/bin/convert "$dir/$1.png" -fft +depth +adjoin "$dir/$1.fft.%d.png"
mv "$dir/$1.fft.0.png" "$dir/$1.fft.magnitude.png"
mv "$dir/$1.fft.1.png" "$dir/$1.fft.phase.png"
/usr/local/bin/convert "$dir/$1.fft.magnitude.png" -auto-level -evaluate log 10000 "$dir/$1.fft.normal.png"
cp "$dir/$1.fft.normal.png" "$dir/$1.fft.normal.edited.png"
zenity --info --text "When GIMP opens, remove the noises (cover them using some bright color, like red or blue) and save the image."
gimp "$dir/$1.fft.normal.edited.png"
/usr/local/bin/convert "$dir/$1.fft.normal.edited.png" "$dir/$1.fft.normal.png" -compose difference -composite -threshold 1000 -negate "$dir/$1.fft.mask.png"
/usr/local/bin/convert "$dir/$1.fft.mask.png" -blur 0x5 -level 50x100% "$dir/$1.fft.mask.blurred.png"
/usr/local/bin/convert "$dir/$1.png" -fft \( -clone 0 "$dir/$1.fft.mask.blurred.png" -compose multiply -composite \) -swap 0 +delete -ift "$dir/$1.fft.filtered.png"
cp "$dir/$1.fft.filtered.png" "$1.final.png"
echo "Done. Check $dir for files."
