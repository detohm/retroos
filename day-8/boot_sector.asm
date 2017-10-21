[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string
call print_string_nl

call load_kernel
; call switch_to_pm

jmp $

%include "boot_sector_print_string.asm"
%include "boot_sector_print_hex.asm"
%include "boot_sector_disk.asm"
%include "32bit_gdt.asm"
%include "32bit_print.asm"
%include "32bit_switch.asm"

[bits 16]
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string
  call print_string_nl

  mov bx, KERNEL_OFFSET ; read from disk to persist in this memory address
  mov dh, 15
  mov dl, [BOOT_DRIVE]
  call disk_load

  mov bx, MSG_LOAD_KERNEL_SUCCESS
  call print_string
  call print_string_nl

  call switch_to_pm

  ret
  jmp $

[bits 32]
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm
  ; call print_string_pm
  ; call print_string_nl

  call KERNEL_OFFSET
  jmp $

BOOT_DRIVE db 0x00 ; 00=floppy 80=hdd
MSG_REAL_MODE db "Started in 16-bit Real Mode",0
MSG_PROT_MODE db "Loaded in 32-bit Protected Mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0
MSG_LOAD_KERNEL_SUCCESS db "Successfully loading kernel into memory",0

times 510-($-$$) db 0
dw 0xaa55

