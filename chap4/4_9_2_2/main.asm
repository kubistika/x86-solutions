extern printf
global main

section .text

main:
	xchg A, B
	xchg A, C
	xchg A, D

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel

    ret
