print_hex:
  pusha
  mov cx, 4

print_hex_char_loop:

  dec cx
  mov ax, dx
  shr dx, 4 ; shift 4 bit (1 hex char) using in next round
  and ax, 0xf ; masking for last 4 bits

  mov bx, HEX_OUT
  add bx, 2 ; just ignore '0x' string
  add bx, cx

  cmp al, 0xa ; detect whether it is char or number (greater than 9)
  jl render_letter
  add byte [bx], 7 ; A = 65 but 9 = 57, so the offet value is 7
  jmp render_letter

render_letter:
  add [bx], al
  cmp cx, 0
  je print_hex_done
  jmp print_hex_char_loop


print_hex_done:
  mov bx, HEX_OUT
  call print_string
  popa
  ret




HEX_OUT:

  db '0x0000',0
