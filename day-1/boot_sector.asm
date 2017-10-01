; Infinite loop to prevent CPU from executing other routines
loop $

; Fill in with zero
times 510-($-$$) db 0

; Magic bit sequences for identifying boot sector
db 0x55
db 0xAA
