global main

section .data
	arr			times 50 db 0
	arrayLength equ $ - arr
section .text

FindMultipleOfK:
	push ebp
	mov ebp, esp

	pushad
	mov ebx, [ebp + 8] ; K
	mov ecx, arrayLength
	mov esi, arr ; pointer to array
.loopArray:
	add esi, ebx
	mov byte [esi], 1
	loop .loopArray

	popad
	pop ebp
	ret 4

main:
	push DWORD 2
	call FindMultipleOfK

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
