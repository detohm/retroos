[org 0x7c00] ; tell the assembler that our offset is bootsector code

; The main routine makes sure the parameters are ready and then calls the function
mov bx, HELLO
call print


; remember to include subroutines below the hang
%include "boot_sector_fn_print.asm"

; data
HELLO:
    db 'Hello, World', 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55
