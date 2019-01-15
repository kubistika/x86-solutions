global main
extern printf

section .data
	PIN_LEN		equ 5

	valid   db '52413'
	invalid db '43534'

	resultFmt db 'PIN is valid? %i', 10, 13, 0

	arr db 5, 9, 2, 5, 4, 8, 1, 4, 3, 6
section .text

IsValid:
	push ebp
	mov ebp, esp

	push ebx 
	push ecx
	push edx
	push esi
	push edi

	mov edx, 0 ; index of digit
	mov ecx, 0 ; index of validator array
	mov esi, [ebp+8] ; offset to input string
	mov edi, arr ; pointer to validator array

.loopStr:
	mov bl, BYTE [esi + ecx]
	sub bl, 30h ; convert char to digit. now ebx is current digit
	cmp bl, BYTE [edi + ecx * 2] 
	jc .invalid
	cmp bl, BYTE [edi + ecx * 2 + 1]
	jg .invalid
	inc ecx
	cmp ecx, PIN_LEN
	jc .loopStr

.valid:
	mov eax, 1
	jmp .ret

.invalid:
	xor eax, eax

.ret:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop ebp

	ret
main:
	push DWORD valid
	call IsValid
	push eax
	push resultFmt
	call printf
	add esp, 8

	push DWORD invalid
	call IsValid
	push eax
	push resultFmt
	call printf
	add esp, 8

	mov	ebx, 0		; exit code, 0=normal
	mov	eax, 1		; exit command to kernel
	int	0x80		; interrupt 80 hex, call kernel
