Branches_1: Branches_1.asm
	nasm -f elf -g -F dwarf Branches_1.asm
	ld -m elf_i386 -o Branches1 Branches_1.o

Branches_2: Branches_2.asm
	nasm -f elf -g -F dwarf Branches_2.asm
	ld -m elf_i386 -o Branches2 Branches_2.o

Copy: Copy.asm
	nasm -f elf -g -F dwarf Copy.asm
	ld -m elf_i386 -o Copy Copy.o

Copy2: Copy2.asm
	nasm -f elf -g -F dwarf Copy2.asm
	ld -m elf_i386 -o Copy2 Copy2.o

Test: Test.asm
	nasm -f elf -g -F dwarf Test.asm
	ld -m elf_i386 -o Test Test.o

Base64: Base64.asm
	nasm -f elf -g -F dwarf Base64.asm
	ld -m elf_i386 -o Base64 Base64.o

clean:
	rm -rf *.o Base64 Branches2 Branches1 Copy
