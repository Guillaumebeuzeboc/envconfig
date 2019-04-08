CC=g++

all: gif_recorder.cpp
	$(CC) -g -Wall -o gif_recorder gif_recorder.cpp -lX11 `pkg-config --cflags --libs libnotify`

clean:
	$(RM) gif_recorder
