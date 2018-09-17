	AREA	Hamming2, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	r0, =0xb6b
	
;clearing bit - r12 will be 8bit of r0	(12bits to 8bits)
	LDR r12, 	=0x0
	AND r5, r0, #0xF00
	EOR r12, r12, r5, LSR #4
	AND r5, r0, #0x070
	EOR r12, r12, r5, LSR #3
	AND r5, r0, #0x004
	EOR r12, r12, r5, LSR #2
	
;Finding c0,c1,c2,c3 - uses r1,r2,r3,r4,r9,r10,r11
	MOV r11, r12
	
	LDR r10, 	=0x1
	LDR r1, 	=0x0	;hold c0
	LDR r2, 	=0x0	;hold c1
	LDR r3, 	=0x0	;hold c2
	LDR r4, 	=0x0	;hold c3
	
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

;Recombining bits to have 12 bits - 4 c3 3 c2 1 c1 c0 (8bits to 12bits)
	MOV r8, #0x0
	ADD r8, r5, r8
	MOV r8, r8, LSL #4
	ADD r8, r6, r8
	MOV r8, r8, LSL #2
	ADD r8, r7, r8
	MOV r8, r8, LSL#2

;Determining the count as even or odd
	AND r4, r4, #0x1
	AND r3, r3, #0x1
	AND r2, r2, #0x1
	AND r1, r1, #0x1
	
;Shifting bits to relevent slots
	MOV r4, r4, LSL #7
	MOV r3, r3, LSL #3
	MOV r2, r2, LSL #1
	
	EOR r8, r4, r8
	EOR r8, r3, r8
	EOR r8, r2, r8
	EOR r8, r1, r8
	
;Error bit indicator in r5, bit indicator in r6
	EOR r5, r0, r8
	AND r6, r5, #0x3
	AND r7, r5, #0x08
	EOR r6, r6, r7, LSR#1
	AND r7, r5, #0x80
	EOR r6, r6, r7, LSR#4
	
	SUB r6, r6, #0x1
	MOV r7, #0x1
	LSL r7, r7, r6
	
	EOR r0, r0, r7
	
	;(12bits to 8bits)
	LDR r1, 	=0x0
	AND r2, r0, #0xF00
	EOR r1, r1, r2, LSR #4
	AND r2, r0, #0x070
	EOR r1, r1, r2, LSR #3
	AND r2, r0, #0x004
	EOR r1, r1, r2, LSR #2
	
	MOV r0, r1
	
	
stop	B	stop

	END	