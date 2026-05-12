build: 
	gcc -m32 -c main.c
	nasm -f elf p9.asm
	gcc -m32 p9.o main.o -L ../../lib -lpc_io -no-pie -z noexecstack -o ../../bin/practica9.exe
run:
	./../../bin/practica9.exe