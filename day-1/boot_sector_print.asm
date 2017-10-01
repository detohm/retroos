; Invoke BIOS interupt call
mov ah, 0x0E
mov al, 'H'
int 0x10
mov al, 'I'
int 0x10
mov al, '!'
int 0x10
int 0x10
int 0x10
mov al, ' '
int 0x10
mov al, 'O'
int 0x10
mov al, 'H'
int 0x10
mov al, 'M'
int 0x10

; Fill in with zero
times 510-($-$$) db 0

; Magic bit sequences for identifying boot sector
db 0x55
db 0xAA
