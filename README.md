# Animal faces

Prompt:

LogoRedmAF, A cute animal called RAM-MS sitting on a bench in the woods. Smiling and looking at the camera. An observant and fuzzy cuddly animal. Background is filled with leafs.

LogoRedmAF, A cute animal called MALIGN sitting on a bench in the woods in spring. In the style of Aardman movies like Wallace and Grommit. Smiling and looking at the camera. An observant and fuzzy cuddly animal. Background is filled with flowers in spring."


How to use: We can parse a directory for filenames. If the file is empty its name will be used to create a face for that name.


## Setup

Create the docker container and provide the name of a project. Generates a png as an output image.

```
conda activate diffuser
```

# Build

```
docker build --no-cache --build-arg conda_env="diffusers" -t animal_faces -f Dockerfile .
```