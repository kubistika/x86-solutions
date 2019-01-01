global main
extern printf

section .data
	counter dd 0
	format  db 'Counter value is: %i', 10, 13, 0
section .text

RecursiveFunction:
	inc DWORD [counter]
	loop RecursiveFunction
	ret

main:
	mov ecx, 70
	call RecursiveFunction

	push DWORD [counter]
	push format
	call printf
	add esp, 8		; align the stack after printf

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
