[bits 16]
switch_to_pm:
  cli ; disable Interupts
  lgdt [gdt_descriptor] ; load GDT descriptor
  mov eax, cr0
  or eax, 0x1 ; set activation flag
  mov cr0, eax ; activate 32 bit mode in cr0
  jmp CODE_SEG:init_pm ; far jump to code segment

  [bits 32]
  init_pm: ; 32-bit world !!!
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; update stack
    mov esp, ebp

    call BEGIN_PM
