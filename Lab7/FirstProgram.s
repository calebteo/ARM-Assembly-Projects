	AREA	HexToVal, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR r1, =TestStr
	LDR r0, =0
	LDRB r2, [r1], #1			;Load 1 byte to r2
while							;While not terminating zero
	CMP r2, #0					;compare if zero
	BEQ endwhile
	
	LSL r0, r0, #4				;Shift number by 4 bits
	AND r4, r2, #0xF0			;Get Indicator - r4
	
	CMP r4, #0x30				;If r4 == 0x30 (30 for a num in ASCII)
	BNE notnum
	MOV r3, #0x30
	B setSub
notnum
	CMP r4, #0x40				;else If r4 == 0x40 (40 for a UpperCase in ASCII)
	BNE notCap
	MOV r3, #0x37
	B setSub
notCap
	MOV r3, #0x57				;else r4 == 0x60 (60 for a LowerCase in ASCII)
setSub
	SUB r2, r2, r3				;Get Value
	ADD r0, r0, r2
	LDRB r2, [r1], #1			;Load next byte
	B 	while

endwhile
stop	B	stop

	AREA	HexToVal, DATA, READWRITE
TestStr	DCB	"123aBc12",0
	END
