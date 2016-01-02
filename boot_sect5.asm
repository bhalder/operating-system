[org 0x7c00]

mov bx, HELLO
call print_string

mov bx, BYE
call print_string

jmp $

%include "print_string.asm"

HELLO:
	db 'Hello, World', 0

BYE:
	db 'Goodbye', 0

times 510-($-$$) db 0
dw 0xaa55
