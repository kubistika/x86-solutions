global main

section .data
	arr			times 50 dd 0
	arrayLength equ $ - arr
section .text

Fib:
	push ebp
	mov ebp, esp

	pushad
	mov esi, [ebp + 8]     ; pointer to array
	mov ecx, [ebp + 12]    ; N = loop counter
	sub ecx, 2			   ; first two values are known

	mov DWORD [esi], 1     ; first value is 1
	mov DWORD [esi + 4], 1 ; seconds value is 1 as well
	mov eax, 1 ; a
	mov ebx, 1 ; b
	mov edx, 0 ; c

	add esi, 8 ; current element is at arr[2]

.calculate:
	; calculate next value
	mov edx, eax   ; c = a
	add edx, ebx   ; c = a + b
	mov [esi], edx ; update c in memory

	mov eax, ebx   ; a = b
	mov ebx, edx   ; b = c

	add esi, 4
	loop .calculate

	popad
	pop ebp
	ret

main:
	push DWORD 10
	push arr
	call Fib

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
