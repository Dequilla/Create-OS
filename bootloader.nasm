BITS 16

start:
	; Set up 4K stack after this bootloader
	; [Remember: Effective Address = Segment*16 + Offset]
	mov ax, 07C0h   ; Set 'ax' equal to the location of this bootloader divided by 16
	add ax, 20h     ; Skip over the size of the bootloader divided by 16
	mov ss, ax      ; Set 'ss' to this location (the beginning of our stack region)
	mov sp, 4096    ; Set 'ss:sp' to the top of our 4K stack

	; Set data segment to where we're loaded so we can implicitly access all 64K from here
	mov ax, 07C0h   ; Set 'ax' equal to the location of this bootloader divided by 16
	mov ds, ax      ; Set 'ds' to the this location

	; Print our message and stop execution
	mov si, message ; Put address of the null-terminated string to output into 'si'
	call print      ; Call our string-printing routine

record:
	call poll_key_blocking
	mov [buff], al
	mov si, buff
	call print
	jmp record

	cli             ; Clear the Interrupt Flag (disable external interrupts)
	hlt             ; Halt the CPU (until the next external interrupt)

data:
	message db 'Welcome to Torii OS!', 0
	buff	db '-', 0

%include "lib/print.nasm"
%include "lib/keyboard.nasm"

; Pad the rest of the progam
times 510-($-$$) db 0	; Pad to 510 bytes which is the first boot sector minus 2 (to fit the magic boot bytes) 
dw 0xAA55	        	; => 0x55 0xAA (little endian byte order)