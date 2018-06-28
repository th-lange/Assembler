
default: clean helloworld

Helloworld:
	nasm -f elf -g -F dwarf HelloWorld.asm
	ld -m elf_i386 -o HelloWorld HelloWorld.o

HelloWorldClean:
	rm -f HelloWorld

SwitchBuffer: SwitchBuffer.asm
	nasm -f elf -g -F dwarf SwitchBuffer.asm
	ld -m elf_i386 -o SwitchBuffer SwitchBuffer.o

SwitchBufferClean:
	rm -f SwitchBuffer

UpperCase: UpperCase.asm
	nasm -f elf -g -F dwarf UpperCase.asm
	ld -m elf_i386 -o UpperCase UpperCase.o

UpperCaseClean:
	rm -f UpperCase

clean: SwitchBufferClean HelloWorldClean UpperCaseClean
	rm -f *.o
