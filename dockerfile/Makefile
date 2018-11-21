all:
	docker build -f installEnvconfig -t beuzeboc/envconfig:latest .

force:
	docker build --no-cache -f installEnvconfig -t beuzeboc/envconfig:latest .

runDotfile:
	docker run -i -t -v $(HOME)/envconfig:/home/toor/envconfig beuzeboc/envconfig bash
