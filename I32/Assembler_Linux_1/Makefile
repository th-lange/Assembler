
default: clean helloworld

helloworld:
	nasm -f elf -g -F dwarf helloWorld.asm
	ld -m elf_i386 -o helloWorld helloWorld.o

clean:
	rm -f *.o helloWorld
