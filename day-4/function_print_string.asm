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
