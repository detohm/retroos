FN_PRINT_HEX:
  mov bx, HEX_OUT
  call FN_PRINT_STRING
  ret

HEX_OUT:
  db '0x0000',0
