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

# Create empty file with "touch /data/bla.jpg"
cmd="$@"
echo "run now: $cmd"
eval $cmd

#
# The above call should create a jpg image for each empty jpg file. We will look for all that do not have a png yet.
for u in `ls /data/*.jpg`; do
    echo "Try to create a circular cutout for ${u}."
    fn=$(basenameee -- "${u}")
    magick "${u}" -gravity center \( \( "${u}" -fill black -draw "rectangle 0,0 %[fx:w],%[fx:h]" \) xc:black -fill white -draw "circle %[fx:w/2] %[fx:h/2] %[fx:w/2] 0" -alpha copy -composite \) -compose copyopacity -composite "/data/${fn%.*}.png"
done

echo "$(date): processing done"
