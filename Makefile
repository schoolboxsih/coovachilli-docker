IMGNAME = coovachilli-schoolbox
IMGTAG = latest
NETWORK = host
RADIUS_SERVER := $(shell docker inspect --format '{{ .NetworkSettings.IPAddress }}' freeradius-schoolbox_run)
RADAUTH_PORT = 1812
RADACC_PORT = 1813

.PHONY: all build

all: build
kill: stop delete
killall: stopall deleteall
dpush: taglatest push

build:
	@docker build -t $(IMGNAME):$(IMGTAG) \
	--build-arg radserver=$(RADIUS_SERVER) \
	--build-arg radauthport=$(RADAUTH_PORT) \
	--build-arg radaccport=$(RADACC_PORT) .

run:
	sudo docker run -t \
    --name $(IMGNAME)_run \
	--net $(NETWORK) \
	--pid $(NETWORK) \
	--ipc $(NETWORK) \
	--privileged \
	$(IMGNAME):$(IMGTAG)

start:
	@docker start $(IMGNAME)_run

stop:
	@docker stop $(IMGNAME)_run

delete:
	@docker container rm $(IMGNAME)_run

deleteall:
	@docker container rm $(shell docker ps -aq)

stopall:
	@docker stop $(shell docker ps -aq)

taglatest:
	docker tag $(IMGNAME):$(IMGTAG) schoolboxsih/$(IMGNAME):$(IMGTAG)

push:
	@docker push schoolboxsih/$(IMGNAME):$(IMGTAG)
