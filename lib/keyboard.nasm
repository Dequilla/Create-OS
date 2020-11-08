
poll_key_blocking:
    mov ah, 0x11
    int 0x16

    jnz .key_pressed

    hlt
    jmp poll_key_blocking

.key_pressed:
    mov ah, 0x10
    int 0x16
    ret