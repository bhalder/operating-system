; Author : Barun Halder
; Date : January, 2016

; Boot sector for our 32-bit protected mode kernel.

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; The memory offset to which we will load kernel
mov dl, 0x40
mov [BOOT_DRIVE], dl ; Setup the boot disk from which to boot

mov bp, 0x9000 ; Setup stack
mov sp, bp

mov bx, MSG_REAL 
call print_string

call load_kernel

call switch_to_pm

jmp $

%include "print_string.asm"
%include "disk_load.asm"
%include "def_gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD
	call print_string

	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]
; Now in protected mode. 

BEGIN_PM:

	mov ebx, MSG_PROT
	call print_string_pm

	call KERNEL_OFFSET 

	jmp $

	BOOT_DRIVE db 0 
	MSG_REAL db "16-bit real mode", 0
	MSG_PROT db "BARUN HALDER 32-bit protected mode", 0
	MSG_LOAD db "Loading kernel into memory", 0

	times 510-($-$$) db 0
	dw 0xaa55
