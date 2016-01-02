; January, 2016
; This code will load dh sectors from disk into memory

disk_load:
        push dx
        mov ah, 0x02 ; The BIOS read sector function
        mov al, dh ; Read dh sectors
        mov ch, 0x00 ; Cylinder 0
        mov dh, 0x00 ; Head 0
        mov cl, 0x02 ; Start reading from the Second sector after boot sector
        int 0x13

        jc disk_error

        pop dx
        cmp dh, al
        jne disk_error
        ret

disk_error:
        mov bx, DISK_ERR
        call print_string
        jmp $

%include "print_string.asm"

DISK_ERR db 'Disk read error.',0
