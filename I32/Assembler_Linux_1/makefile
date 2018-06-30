

default: clean hello

hello:
	nasm -f elf -g -F dwarf HelloWorld.asm
	ld -m elf_i386 -o HelloWorld HelloWorld.o

helloClean:
	rm -f HelloWorld HelloWorld.o

switchbuffer: SwitchBuffer.asm
	nasm -f elf -g -F dwarf SwitchBuffer.asm
	ld -m elf_i386 -o SwitchBuffer SwitchBuffer.o

switchBufferClean:
	rm -f SwitchBuffer SwitchBuffer.o

clean: helloClean switchBufferClean

