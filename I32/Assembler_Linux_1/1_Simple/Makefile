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

ToUpper: ToUpper.asm ToUpper2.asm
	nasm -f elf -g -F dwarf -o ToUpper.o ToUpper.asm
	ld -m elf_i386 -o ToUpper ToUpper.o
	nasm -f elf -g -F dwarf -o ToUpper2.o ToUpper2.asm
	ld -m elf_i386 -o ToUpper2 ToUpper2.o

ToUpperClean:
	rm -f ToUpper ToUpper2

ToHexString: ToHexString.asm
	nasm -f elf -g -F dwarf ToHexString.asm
	ld -m elf_i386 -o ToHexString ToHexString.o

ToHexStringClean:
	rm -f ToHexString

clean: SwitchBufferClean HelloWorldClean UpperCaseClean ToUpperClean ToHexStringClean
	rm -f *.o
