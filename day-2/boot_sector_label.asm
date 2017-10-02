[org 0x7C00]

; Invoke BIOS interupt call
mov ah, 0x0E
mov al, [test_func]
int 0x10

; label
test_func:
    db "O"

; zero padding
times 510-($-$$) db 0
; Magic bit sequences for identifying boot sector
db 0x55
db 0xAA
