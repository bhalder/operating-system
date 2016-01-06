; Author : Barun Halder
; Date : January, 2016

; Assembly code to define the Global Descriptor Table

; GDT

gdt_start:

; The first entry in the GDT has to be NULL. 
; Fill up the first entry as NULL descriptor.
; dd : Double Word (4 bytes)
gdt_null:
	dd 0x0
	dd 0x0

; Define the Code Segment Descriptor
gdt_code:
; Base = 0x00
; Limit = 0xfffff
; flags : present (1) privilege (00) descriptor type (1) => 1001b
; type : Code (1) Conforming (0) Readable (1) Accessed (0) => 1010b
; flags: granularity(1) 32-bit default (1) 64-bit segment (0) AVL (0) => 1100b

; Start filling the descriptor!
	dw 0xffff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0

; Define the Data Segment Descriptor
gdt_data:
; Base = 0x00
; Limit = 0xfffff
; flags : present (1) privilege (00) descriptor type (1) => 1001b
; type : Code (0) Expand Down (0) Writable (1) Accessed (0) => 0010b
; flags: granularity(1) 32-bit default (1) 64-bit segment (0) AVL (0) => 1100b

; Start filling the descriptor
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
; Putting a label for us to calculate useful constants later.
gdt_end: 
	
; Prepare the gdt_descriptor pointer (48bits)
; This will be passed to the CPU.
gdt_descriptor:
; First the Size (16 bits)
	dw gdt_end - gdt_start - 1
; Next the start Address (32bits)
	dd gdt_start

; Define constants for the Code Segment and the Data Segment.
; These are the values that the segments should contain
; when in protected mode.

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

; Here we would have prepared the GDT and the GDT descriptor within the 
; boot sector. 
; We can now instruct the CPU to make the switch from 16-bit real mode
; to 32-bit protected mode.
