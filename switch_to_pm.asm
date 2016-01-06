; Author : Barun Halder
; Date : Jan, 2016

; In this assembly we make the SWITCH from the real mode to the protected mode.
; The way we do that is by setting a special control register, cr0. 
; Now, because we want to ensure that the switch is successful, we would want
; to ensure that there are no surprises caused because of pipelining.
; To achieve this we perform a FAR JUMP ( jmp with the segment address added )
; Doing this forces the CPU to flush all the instructions.

[bits 16] ; initially real mode
switch_to_pm:
; Ensure you are not bothered by any interrupts
; If we do not do this, then there will be too many interrupts
; and we will land ourselves in a very sticky situation.

	cli
	; Load the GDT table

	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
; This is the FAR jump to flush the pipelined instructions`
	jmp CODE_SEG:init_pm

[bits 32]
; initialize registers and the stack in PM
init_pm:
; Welcome to PM mode
; All old segments are meaningless
; Reset all the segments to point to 
; the Data Segment descriptor defined within within GDT

	mov ax, DATA_SEG 
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; Update the stack position so it is right at top of the free space.
	mov ebp, 0x90000
	mov esp, ebp

	call BEGIN_PM

	call BEGIN_PM ;
