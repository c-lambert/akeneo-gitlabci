build:
	docker build . -t 'numendo/akeneo-gitlabci:6.1' --platform linux/amd64,linux/arm64
push:
	docker push 'numendo/akeneo-gitlabci:6.1'
