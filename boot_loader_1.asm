; Barun Halder
; January 2016
; Bootloader program to read sectors from a specified disk

[org 0x7c00]
	mov [BOOT_DRIVE], dl

	mov bp, 0x8000 ; Reset Stack, so that it stays of out the way
	mov sp, bp

	mov bx, 0x9000
	mov dh, 5

	mov dl, [BOOT_DRIVE]

	call disk_load

	jmp $

%include "read_disk_3.asm"

BOOT_DRIVE : db 0

; Padding
times 510-($-$$) db 0
dw 0xaa55

; Test Code -
times 256 dw 0xDEAD
times 256 dw 0xBEEF
