	AREA	Hamming, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR r1, =0xAC
	MOV r12, r1
	MOV r11, r12
	
	LDR r10, 	=0x1
	LDR r1, 	=0x0
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	LDR r4, 	=0x0
	
	AND r9, r11, r10
	ADD r1, r9, r1
	ADD r2, r9, r2
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r1, r9, r1
	ADD r3, r9, r3
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r2, r9, r2
	ADD r3, r9, r3
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r1, r9, r1
	ADD r2, r9, r2
	ADD r3, r9, r3
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r1, r9, r1
	ADD r4, r9, r4
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r2, r9, r2
	ADD r4, r9, r4
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r1, r9, r1
	ADD r2, r9, r2
	ADD r4, r9, r4
	MOV	r11, r11, LSR #1
	
	AND r9, r11, r10
	ADD r3, r9, r3
	ADD r4, r9, r4
	
	MOV r5, #0xF
	MOV r6, #0x7
	MOV r7, #0x1
	
;Separating 8 bits to 4, 3, 1
	AND r5, r5, r12, ROR #4
	AND	r6, r6, r12, ROR #1 
	AND r7, r7, r12

;Recombining bits to have 12 bits - 4 c3 3 c2 1 c1 c0
	MOV r0, #0x0
	ADD r0, r5, r0
	MOV r0, r0, LSL #4
	ADD r0, r6, r0
	MOV r0, r0, LSL #2
	ADD r0, r7, r0
	MOV r0, r0, LSL#2

;Determining the count as even or odd
	AND r4, r4, #0x1
	AND r3, r3, #0x1
	AND r2, r2, #0x1
	AND r1, r1, #0x1
	
;Shifting bits to relevent slots
	MOV r4, r4, LSL #7
	MOV r3, r3, LSL #3
	MOV r2, r2, LSL #1
	
	EOR r0, r4, r0
	EOR r0, r3, r0
	EOR r0, r2, r0
	EOR r0, r1, r0
	
	
stop	B	stop

	END	