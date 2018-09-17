	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	MOV		r1, #0x8
	MUL		r0, r1, r1
	LDR		r2, =4
	MUL		r0, r2, r0
	LDR		r2, =3
	MUL		r2, r1, r2
	ADD		r0, r0, r2
	
stop	B	stop
	AREA	Arithmetic1, CODE, READWRITE
	END	