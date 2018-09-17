	AREA	BitPattern, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =2_01110001000111101100111000111111
	
	LDR 	r2, =33	;Use to rotate around 32 bits
	LDR 	r3, =0x0	;NumOf1s
	LDR 	r0, =0x0	;Count number of contigous sequences
	MOVS 	r2, r2
	
while
	BEQ 	endwh
	AND 	r4, r1, #0x1
	CMP 	r4, #0x1
	BNE		else1
	ADD 	r3, r3, #0x1
	B		endif1
else1	
	CMP 	r3, #0x0
	BLS		endif2
	ADD 	r0, r0, #0x1
	LDR 	r3, =0x0
endif2
endif1
	MOV 	r1, r1, LSR #1
	SUBS 	r2, r2, #0x1
	B		while
endwh	
stop	B	stop
	END	