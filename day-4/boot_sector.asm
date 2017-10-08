[org 0x7c00]

; Try store 'C' in register
mov al, 'C'

mov bx, HELLO_MSG
call FN_PRINT_STRING

; Try to print 'C' which declared before calling the function,
; It will not print put the 'C' if it's manipulated in the function.
; But we use pusha & popa to save current state of all register and restore back when return of function call
; Therefore, the system print 'C' correctly.
mov ah, 0x0e
int 0x10

; Test print Hex
mov dx, 0x1c12
call FN_PRINT_HEX

jmp $

%include "function_print_string.asm"
%include "function_print_hex.asm"

; Data
HELLO_MSG:
  db 'hello world',0

times 510 - ($ - $$) db 0
dw 0xaa55
