C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = $(C_SOURCES:.c=.o)

all: os-image

run: all
	qemu-system-x86_64 -fda os-image

os-image: boot/boot_sector.bin kernel.bin
	cat $^ > os-image


# KERNEL
kernel.bin: kernel/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	i386-elf-gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@


# BOOT SECTOR
%.bin: %.asm
	nasm $< -o $@

clean:
	rm *.bin *.o os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o
