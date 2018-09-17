	AREA	ValToHex, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	r1, =0xFEED1234
	LDR r0, =0xA1000400
	MOV r4, #0x8
	LDR r6, =28
	ROR r1, r6

for CMP r4, #0				;For loop 8 counts
	BEQ endfor
	AND r2, r1, #0xF		;Isolate the 4 LSB
	
	CMP r2, #0x9			;if Byte > 9
	BLO notLetter			;Bype < 9
	MOV r3, #0x37			;Convertor number for letters
	B endif1
notLetter
	MOV r3, #0x30			;Convertor number for numbers
endif1
	ADD  r2, r3
	STRB r2, [r0], #1		;Store
	SUBS r4, r4, #1			;Count - 1
	ROR r1, r6				;Rotate to desired byte
	B for
endfor
	MOV r2, #0x0
	STRB r2, [r0]
stop	B	stop

	END	