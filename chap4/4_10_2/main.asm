global main
extern printf

section .data
	arr			dd 2, 1, 4, 3
	arrayLength equ ($ - arr) / 4
section .text

main:
	mov esi, arr
	mov ecx, arrayLength/2  ; we're processing the array in pairs

.loopArray:
	mov eax, [esi]
	xchg eax, [esi+4]
	mov [esi], eax
	add esi, 8
	loop .loopArray

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel

    ret
