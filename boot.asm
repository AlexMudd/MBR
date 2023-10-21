 BITS 16
 	mov ax, 0x7c0
 	mov es, ax
 	mov ds, ax
 	
	mov ax, 3
	int 0x10
	mov di, key
	xor cx, cx

getkeyloop:
	mov ah, 0
	int 0x16

	cmp al, 0x0d
	jz start

	inc cx

	stosb
	jmp getkeyloop

start:
	mov dx, cx
	xor cx, cx
	
	mov si, len
	lodsb
	mov cl, al
	xor ax, ax
	xor si, si
	
	mov si, msg
	
	xor di, di

	mov ax, 0xb87d
	
	mov es, ax
	xor bx, bx

	
	
loop1:
	lodsb
	xor al, [key + bx]
	mov ah, 0xb
	stosw


	dec cx
	cmp cx, 0
	je halt

	inc bx
	cmp dx, bx
	je zero

	jmp loop1

zero:
	xor bx, bx
	jmp loop1

halt:
	jmp halt

key:
	times 16 db 0

len:
	times 1 db 0

msg:
	times 510 - ($-$$) db 0
	dw 0xaa55
