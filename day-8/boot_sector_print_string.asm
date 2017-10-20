; Function
print_string:
  pusha

print_string_start:

  mov al, [bx]
  cmp al, 0
  je print_string_done

  mov ah, 0x0e
  int 0x10

  add bx, 1
  jmp print_string_start

print_string_done:
  popa
  ret

print_string_nl:
  pusha
  mov ah, 0x0e

  mov al, 0x0a
  int 0x10

  mov al, 0x0d
  int 0x10

  popa
  ret
