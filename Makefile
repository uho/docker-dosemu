CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

run: image 
	docker run -t -i -v $(CWD):/home/dosemu -v $(CWD)/cdrom:/media/cdrom dosemu

image:
	docker build -t dosemu .
	@tail -1 Dockerfile
