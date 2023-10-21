all:
	@echo 'build - to build injector app and boot'
	@echo 'inject - to encrypt message and inject it into boot'
	@echo 'run - to run boot'
	@echo 'clean - to clean directory of executable files'

build:
	gcc encoder.c -o encoder.exe
	nasm -fbin boot.asm -o floppy.bin

inject:
	@./encoder.exe
	@echo 'Injected'

run:
	@qemu-system-i386 floppy.bin
	
clear:
	@rm -vf *.exe *.bin
