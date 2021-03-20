# docker-dosemu - Run DOS Programs Everywhere

This is a setup of [DOSEMU](http://www.dosemu.org/) 1.4 using [Docker](https://www.docker.com/).

## Usage

    docker run -i -t --rm -v $(pwd):/home/dosemu -v $(pwd)/cdrom:/media/cdrom uhoffmann/dosemu args ...


Inside DOSEMU drive `D:` will be mounted to `/home/dosemu` thus the Docker command above will make the current
directory available as drive `D:`. Likewise drive `E:` will be mounted to `/media/cdrom´ and you can use 
Docker to map that wherever you want.

As an example, to list your the current directory from DOS you can use:

    docker run -i -t --rm -v $(pwd):/home/dosemu -v $(pwd)/cdrom:/media/cdrom uhoffmann/dosemu -dumb "dir D:"


If you have a DOS executable, say `PROG.com` you can start it directly with

    docker run -i -t --rm -v $(pwd):/home/dosemu -v $(pwd)/cdrom:/media/cdrom uhoffmann/dosemu PROG.COM

The command line accepts the DOSEMU options as described in the [DOSEMU documentation](http://www.dosemu.org/docs/README/1.4/). Only text and dumb mode are supported right now.

Without argument the image boots into `COMMAND.COM` and you can work in the DOS environment. Exit the emulator with `exitemu`.

DPMI has beend disabled as DOSEMU requires the Linux kernel to [provide 16bit-Segments](). 
The modern kernels that current Docker uses do not support this any mode withou recompiation. 
Any suggestions for workarounds are welcome.

## Create Your Own Image

To build the image locally you can tweak `dosemu.conf` then use the provided `Dockerfile`:

    make image

and run your locally built image:

    make run

## Background Information

This image uses Debian Stretch as its base and just installs the DOSEMU 1.4 package
from contrib that was available at that time. Newer Debian does no longer support DOSEMU. 

## Feedback Welcome

If you have any tips for improving this image, I'd be happy to hear from you.

Regards,  
	
Ulrich Hoffmann



