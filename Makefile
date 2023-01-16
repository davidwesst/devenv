SHELL = /bin/bash

build:
	docker build --tag devenv -f ./src/Dockerfile ./src

clean:
	docker rm devenv
	ssh-keygen -f ~/.ssh/known_hosts -R "[localhost]:2222"

connect:
	ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null root@localhost

run:
	docker run --name devenv \
				--hostname devenv \
				--detach \
				--env SSH_PASSWORD="password" \
			    --publish 2222:22 \
				devenv
start:
	docker start devenv

stop:
	docker stop devenv


