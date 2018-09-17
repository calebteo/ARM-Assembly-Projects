	AREA	Hamming, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	r1, =0xAC
	MOV r12, r1 
	
	AND r4, r12, #0x5B 
	LDR r1, 	=0x1
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	MOV	r4, r4, LSR #1
	
	AND r2, r4, r1
	ADD r3, r3, r2
	
	AND r8, r3, #0x1			;r8 has c0
	
	
	AND r5, r12, #0xAD
	LDR r1, 	=0x1
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	MOV	r5, r5, LSR #1
	
	AND r2, r5, r1
	ADD r3, r3, r2
	
	AND r9, r3, #0x1			;r9 has c1
	
	
	AND r6, r12, #0x8E
	LDR r1, 	=0x1
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	MOV	r6, r6, LSR #1
	
	AND r2, r6, r1
	ADD r3, r3, r2
	
	AND r10, r3, #0x1			;r10 has c2
	
	AND r7, r12, #0xF0
	LDR r1, 	=0x1
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	MOV	r7, r7, LSR #1
	
	AND r2, r7, r1
	ADD r3, r3, r2
	
	AND r11, r3, #0x1			;r11 has c3
	
	MOV r5, #0xF
	MOV r6, #0x7
	MOV r7, #0x1
	
;Separating 8 bits to 4, 3, 1
	AND r2, r5, r12, ROR #4
	AND	r3, r6, r12, ROR #1 
	AND r4, r7, r12

;Recombining bits to have 12 bits - 4 c3 3 c2 1 c1 c0
	MOV r0, #0x0
	ADD r0, r2, r0
	MOV r0, r0, LSL #4
	ADD r0, r3, r0
	MOV r0, r0, LSL #2
	ADD r0, r4, r0
	MOV r0, r0, LSL#2

;Shifting bits to relevent slots
	MOV r11, r11, LSL #7
	MOV r10, r10, LSL #3
	MOV r9, r9, LSL #1
	
	EOR r0, r11, r0
	EOR r0, r10, r0
	EOR r0, r9, r0
	EOR r0, r8, r0
	
stop	B	stop

	END	