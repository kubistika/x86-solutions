global main
extern printf

section .data
	encFmt db 'Encrypted Message: %s', 10, 13, 0
	decFmt db 'Decrypted Message: %s', 10, 13, 0

	key    db 'CDCDBERPCD'
	msg	   db 'ShalomLeha'
	MSG_LEN equ $ - msg
section .text

XORStr:
	push ebp
	mov ebp, esp

	push ecx
	push esi
	push edi

	mov esi, [ebp+8] ; offset to input string
	mov edi, [ebp+12] ; offset to key string
	mov ecx, MSG_LEN

.loopStr:
	mov bl, BYTE [edi]
	xor BYTE [esi], bl
	inc esi
	inc edi
	loop .loopStr

.ret:
	pop edi
	pop esi
	pop ecx
	pop ebp

	ret 8

main:
	push DWORD key
	push DWORD msg
	call XORStr

	push DWORD msg
	push encFmt
	call printf
	add esp, 8

	push DWORD key
	push DWORD msg
	call XORStr

	push DWORD msg
	push decFmt
	call printf
	add esp, 8

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
