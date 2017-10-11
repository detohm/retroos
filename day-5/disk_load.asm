; load Dh sectors to ES:Bx from drive Dl
disk_load:
  pusha
  push dx       ; store so later can resume the value
  mov ah, 0x02  ; BIOS read sector
  mov al, dh    ; Read Dh sector
  mov ch, 0x00  ; cylinder 0
  mov dh, 0x00  ; head 0
  mov cl, 0x02  ; start reading from second sector (base is 1 which is boot sector)

  int 0x13      ;execute BIOS interupt

  jc disk_error ; jump if carry flag set

  pop dx        ; restore dx
  cmp dh, al
  jne disk_error_2
  popa
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  mov dh, ah
  call print_hex
  jmp $

disk_error_2:
  mov bx, DISK_ERROR_MSG_2
  call print_string
  jmp $

; vars
DISK_ERROR_MSG:
  db "Disk Read Error !!!", 0

DISK_ERROR_MSG_2:
  db "Sector Error !!!", 0




