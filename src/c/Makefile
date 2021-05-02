all: compile install

compile:
	gcc -o jiffy.exe jiffy.c
	gcc -O1 -o jiffy_O1.exe jiffy.c
	gcc -O2 -o jiffy_O2.exe jiffy.c
       
install:
	mv -f *.exe ${HOME}/.local/bin 
