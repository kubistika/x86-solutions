extern printf
global main

section .data
	bigEndian    db 12h, 34h, 56h, 78h
	littleEndian dd 0

	format db 'After conversation: littleEndian = 0x%08x', 10, 13
section .text

main:
	mov al, byte [bigEndian]     ; al = 12h
	mov ah, byte [bigEndian + 1] ; ah = 34h
	mov bl, byte [bigEndian + 2] ; bl = 56h
	mov bh, byte [bigEndian + 3] ; bh = 78h

	mov byte [littleEndian], bh
	mov byte [littleEndian+1], bl
	mov byte [littleEndian+2], ah
	mov byte [littleEndian+3], al

	push dword [littleEndian]
	push dword format
	call printf
	add esp, 8

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel

    ret
