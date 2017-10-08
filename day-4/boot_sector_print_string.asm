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

jmp $


; Function
FN_PRINT_STRING:
  pusha

FN_PRINT_STRING_START:

  mov al, [bx]
  cmp al, 0
  je FN_PRINT_STRING_DONE

  mov ah, 0x0e
  int 0x10

  add bx, 1
  jmp FN_PRINT_STRING_START

FN_PRINT_STRING_DONE:
  popa
  ret


; Data
HELLO_MSG:
  db 'hello world',0

times 510 - ($ - $$) db 0
dw 0xaa55
