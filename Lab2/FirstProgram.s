	AREA	AsciiConversion, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R7, ='1'
	LDR	R6, ='0'
	LDR	R5, ='3'
	LDR	R4, ='4'
	LDR	R3, ='2'
	LDR	R2, ='7'
	LDR	R1, ='9'
	MOV R8, #0x30
	
	SUB 	R7, R7, R8
	SUB		R6, R6, R8
	SUB 	R5, R5, R8
	SUB 	R4, R4, R8
	SUB 	R3, R3, R8
	SUB 	R2, R2, R8
	SUB 	R1, R1, R8
	
	LDR		R8, = 1000000
	MUL 	R7, R8, R7
	
	LDR		R8, = 100000
	MUL 	R6, R8, R6
	
	LDR		R8, = 10000
	MUL 	R5, R8, R5
	
	LDR		R8, = 1000
	MUL 	R4, R8, R4
	
	LDR		R8, = 100
	MUL 	R3, R8, R3
	
	LDR		R8, = 10
	MUL 	R2, R8, R2
	
	MOV 	R0, R7
	ADD		R0, R6, R0
	ADD		R0, R5, R0
	ADD		R0, R4, R0
	ADD		R0, R3, R0
	ADD		R0, R2, R0
	ADD		R0, R1, R0
	
stop	B	stop

	END	