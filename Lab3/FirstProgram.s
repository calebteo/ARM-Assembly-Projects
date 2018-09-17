	AREA	Parity, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	r0, 	=0x16
	MOV r4, r0
	LDR r1, 	=0x1
	LDR r2, 	=0x0
	LDR r3, 	=0x0
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	MOV	r0, r0, LSR #1
	
	AND r2, r0, r1
	ADD r3, r3, r2
	
	MOV r3, r3, LSL #7
	LDR r2, 	=128
	
	AND r3, r2, r3
	EOR r0, r3, r4
	

stop	B	stop

	END	