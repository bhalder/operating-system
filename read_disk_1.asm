; Barun Halder
; January, 2016

; ASM code to read bytes from the appropriate disk.
; Format is - Drive, Cylinder, Track, Sector
; BIOS interrupt that will help us is - 0x13

mov ah, 0x02
mov dl, 0 ; Select which drive - Floppy in this case
mov ch, 3 ; Select which cylinder
mov cl, 4 ; Select which sector
mov al, 5 ; Select HOW MANY sectors to be read

; Set the es to appropriate value

mov bx, 0xa000
mov es, bx
mov bx, 0x1234 ; The address that will go is (0xa000*16)+0x1234
int 0x13
