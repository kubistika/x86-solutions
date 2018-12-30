global main

section .data
	arr			dd 2, 1, 4, 3
	arrayLength equ ($ - arr) / 4
section .text

main:
	mov esi, arr
	mov ecx, arrayLength/2   ; we're processing the array in pairs
	mov edi, 0               ; first element index
	mov edx, arrayLength - 1 ; last element index

.reverseArray:
	mov eax, [esi + edi * 4] ; eax = left element
	mov ebx, [esi + edx * 4] ; ebx = right element
	xchg [esi + edi * 4], ebx ; left = right
	xchg [esi + edx * 4], eax ; right = left
	inc edi
	dec edx
	loop .reverseArray

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
