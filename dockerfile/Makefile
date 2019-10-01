all:
	docker build -f installEnvconfig -t beuzeboc/envconfig:latest .

force:
	docker build --no-cache -f installEnvconfig -t beuzeboc/envconfig:latest .

runDotfile:
	docker run -i -t -v $(HOME)/envconfig:/home/toor/envconfig beuzeboc/envconfig bash

travis:
	docker	run -i -t -v $(HOME)/envconfig:/home/toor/envconfig beuzeboc/envconfig bash -c "cd /home/toor/envconfig && sudo ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && export DEBIAN_FRONTEND=noninteractive && printf 'y\ny\ny\ny\n~/.mozilla/firefox/\ny\ny\ny\n' | ./setup_env.bash"
