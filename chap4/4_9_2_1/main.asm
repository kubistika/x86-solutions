extern printf
global main

section .data
	format db 'Value is 0x%08x!', 10, 13
	three  dd 12345678h

section .text

main:
	; manipulate three
	mov ax, word [three]     ; ax = 5678h
	mov bx, word [three+2]   ; bx = 1234h
	mov [three], bx
	mov [three+2], ax

	; print three
	push dword [three]
	push dword format
	call printf
	add esp, 8

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel

    ret
