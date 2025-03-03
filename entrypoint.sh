#!/bin/bash --login
# The --login ensures the bash configuration is loaded.

# Expect one argument (the name of the conda environment)
if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
  conda_env="$CONDA_DEFAULT_ENV"
fi

if [ -z "$conda_env" ]; then
    echo "Usage: <conda-env>"
    exit -1
fi

cmd="$@"
echo "run now: $cmd"
eval $cmd

# add the imagemagick commands here to convert the square image into the logo format
# magick convert input.jpg -gravity center ( -size 480x480 xc:black -fill white -draw "circle 240 240 240 0" -alpha copy ) -compose copyopacity -composite output.png

echo "$(date): processing done"
