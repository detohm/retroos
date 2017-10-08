[org 0x7C00]

mov bx, HELLO_MSG
call FN_PRINT_STRING

HELLO_MSG:
  db 'hello world',0


