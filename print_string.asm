print_string:
	test:
	mov al, [bx]
	add bx, 0x01
	mov ah, 0x0e
	int 0x10
	mov cx, [bx]
	cmp cx, 0x00
	jne test
	ret
