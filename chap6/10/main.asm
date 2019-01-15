global main
extern printf

section .data
	arr1 db 00001111b, 00000000b ; P = true
	ARR1_LEN equ $ - arr1
	arr2 db 00001111b, 00000001b, 00111000b ; P = true
	ARR2_LEN equ $ - arr2
	arr3 db 00001111b, 00000001b, 00110000b ; P = false
	ARR3_LEN equ $ - arr3

	resultFmt db 'Array bytes is parity = %i', 10, 13, 0

section .text
CheckArrayParity:
	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push esi

	mov esi, [ebp+8] ; offset of array
	mov ecx, [ebp+12] ; array length
	dec ecx

	mov bl, BYTE [esi]
	inc esi

.loop:
	xor bl, BYTE [esi]
	pushfd ; push eflags
	inc si ; as we don't want any instruction here to affect parity flag
	popfd
	loop .loop
	
	mov eax, 1
	jp .ret
	xor eax, eax

.ret:
	pop esi
	pop ecx
	pop ebx
	pop ebp
	ret 8

main:
	push DWORD ARR1_LEN
	push DWORD arr1
	call CheckArrayParity
	push eax
	push resultFmt
	call printf
	add esp, 8

	push DWORD ARR2_LEN
	push DWORD arr2
	call CheckArrayParity
	push eax
	push resultFmt
	call printf
	add esp, 8

	push DWORD ARR3_LEN
	push DWORD arr3
	call CheckArrayParity
	push eax
	push resultFmt
	call printf
	add esp, 8

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
