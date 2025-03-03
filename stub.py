import glob
import numpy as np
import sys
import os
import json

from diffusers import DiffusionPipeline


if len(sys.argv) != 2:
    print("Error: wrong number of arguments (%d), should be 1 (image folder with pngs)." % (len(sys.argv)-1))
    sys.exit(-1)

imagefolder = sys.argv[1]

if not(os.path.exists(imagefolder)):
    try:
        print("Info: create image folder \"%s\"" % (imagefolder))
        os.mkdir(imagefolder,0o777)
    except OSError as error:
        (error)
    
files = []
print('glob: {}'.format(imagefolder))
for fname in glob.glob(imagefolder+"/*.png", recursive=False):
    #print("loading: {}".format(fname))
    if os.path.isfile(fname) and os.path.getsize(fname) == 0:
        files.append(fname)

print("file count: {}".format(len(files)))

pipe = DiffusionPipeline.from_pretrained("stabilityai/stable-diffusion-xl-base-1.0")
pipe.load_lora_weights("artificialguybr/LogoRedmond-LogoLoraForSDXL-V2")
#pipe = pipe.to("mps")
for fname in files:
    # remove extension
    fname = os.path.splitext(os.path.basename(fname))[0]
    print("processing: {}".format(fname))
    prompt = "LogoRedmAF, The face of a cute animal called %s. Smiling and looking at the camera. Observant. Background is a wooden area." % (fname)
    image = pipe(prompt).images[0]

    # save image
    image.save(imagefolder+"/"+fname+".png")

