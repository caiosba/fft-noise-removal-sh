## Remove noises from images using Fourier Transforms on ImageMagick

This Shell Script aims to remove noise from images by using Fourier Transforms on ImageMagick.
This kind of noise is easy to remove in the frequency domain as the patterns show up as either a pattern of a few dots or lines. Steps:

1. Transform the image to the frequency domain
2. Create a grayscale version of the spectrum
3. Mask the dots or lines (GIMP is called here, so you need to manually do it)
4. Threshold it
5. Multiply the binary mask image with the magnitude image
6. Transform back to the spatial domain

Usage: `sh fft_noise.sh <image file>`

The script will generate an image named `<image file>.final.png` on the same directory. The other generated images (mask, frequency domain, spectrum, magnitude, phase, etc.) are stored in a directory located in the /tmp directory. The path to this directory is informed at the end of the execution.

Dependencies: imagemagick (convert) with fft support, zenity and gimp.

Check the examples directory.

Caio SBA <caiosba@gmail.com>, 2013.
