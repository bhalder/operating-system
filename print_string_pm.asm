; Barun Halder
; January, 2016

; Code to print to screen on the 32-bit protected mode
; The interrupts and functions initially available to us
; via the BIOS is no longer available in 32-bit mode

; We have VGA - The screen is 80x25 characters
; The screen is mapped on to the memory
;
; A font is already set for this. 
; All you'll have to do is, write on the appropriate
; location in the memory, and the character would come up
; Each letter is represented using two bytes
; One byte is the ASCII value of the character
; Other byte is the Foreground/Background Color and 
; Whether you want the character to blink
;
; This memory starts at 0xb8000
; Bytes to be changed - 0xb8000 + 2 * ( row * 80 + col )

[bits 32]
VIDEO_MEM equ 0xb8000 ; Video memory start
WHITE_BLACK equ 0x0f ; What KIND of font you want 

print_string_pm:
	pusha
	mov edx, VIDEO_MEM
	
loop:
	mov al, [ebx] ; ebx will have the character ASCII value
	mov ah, WHITE_BLACK
	cmp al, 0
	je done

	mov [edx], ax

	add ebx, 1
	add edx, 2

	jmp loop

done:
	popa
	ret
