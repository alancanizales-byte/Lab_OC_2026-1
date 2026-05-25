build:
	rm -f *.o ../../bin/practica10.exe
	gcc -m32 -fno-pie -fno-builtin -c main.c -o main.o
	nasm -f elf p10.asm -o p10.o
	gcc -m32 main.o p10.o -L ../../lib -lpc_io -no-pie -z noexecstack -o ../../bin/practica10.exe

run:
	./../../bin/practica10.exe