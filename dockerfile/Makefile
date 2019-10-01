all:
	docker build -f installEnvconfig -t beuzeboc/envconfig:latest .

force:
	docker build --no-cache -f installEnvconfig -t beuzeboc/envconfig:latest .

runDotfile:
	docker run -i -t -v $(HOME)/envconfig:/home/toor/envconfig beuzeboc/envconfig bash

travis:
	docker run -i -t -v $(HOME)/envconfig:/home/toor/envconfig beuzeboc/envconfig bash -C "cd /home/toor/envconfig; printf 'y\ny\ny\ny\n~/.mozilla/firefox/\ny\ny\ny\n' | ./setup_env.bash"
