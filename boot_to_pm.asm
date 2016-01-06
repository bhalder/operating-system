; Author : Barun Halder
; Date : January, 2016

; This boot loader will load the device into 32-bit mode.

[org 0x7c00] ; Where all the code must begin in BIOS mode
	mov bp, 0x9000 ; Set the stack
	mov sp, bp

	mov bx, MSG_REAL
	call print_string

	call switch_to_pm

;	jmp $ ; Loop for ever

%include "print_string.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"
%include "def_gdt.asm"

[bits 32]
; We are in protected mode bae!

BEGIN_PM:
	mov ebx, MSG_PROT
	call print_string_pm
 
	jmp $

MSG_REAL db "Started in 16-bit", 0
MSG_PROT db "Started in 32-bit", 0

times 510-($-$$) db 0
dw 0xaa55
