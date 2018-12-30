all: link

main.o:  main.asm
		nasm -f elf32 main.asm -g

link:   main.o
		gcc -g -m32 -o main.out main.o
