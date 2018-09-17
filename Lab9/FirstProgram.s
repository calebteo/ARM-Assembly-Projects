	AREA	RPN, CODE, READONLY
	IMPORT	main
	EXPORT	start
	
start
	MOV r0, #0				;r0 = results
	LDR r1, =rpnexp			;r1 = address
	LDR r3, =0xA1000400		;Load to address for stack (currently using sp) 
	LDRB r2, [r1], #1		;r2 = currbit
	MOV r4, #1
while 
	CMP r2, #0
	BEQ endProg
	CMP r2, #0x30			;if r2 > 0
	BLO endif1
	CMP r2, #0x39			;if r2 < 9
	BHS endif1				;Bit is between 0 - 9 ie.number
	SUB r2, #0x30
	BL Num
	;BL HexToVal
	;ADD sp, #4
	;MOV r2, r5				;Change to Val
	ADD r3, r6
	STR r5, [r3,#-4]!
	B endif2
endif1
	CMP r2, #0x20 			;if r2 == space
	BEQ flipInd
	CMP r2, #0x2B			;if r2 == '+'
	BEQ addFn				;Go to addFn
	CMP r2, #0x2D			;if r2 == '-'
	BEQ subFn 				;Go to subFn
	CMP r2, #0x2A			;if r2 == '*'
	BEQ mulFn   			;Go to mulFn
	CMP r2, #0x2F			;if r2 == '/'
	BEQ divFn				;Go to divFn
	CMP r2, #0x5E			;if r2 == '^'
	BEQ powFn				;Go to powFn
	CMP r2, #0x6E			;if r2 == 'n'
	BEQ negFn				;Go to negFn
	CMP r2, #0x21			;if r2 == '!'
	BEQ facFn				;Go to facFn
	
	;ADD sp, r6
	;STRB r5, [sp,#-4]!		;Push to Stack
endif2
	LDRB r2, [r1], #1		;Load next bit
	B while	
	
Num
	CMP r4, #0
	BNE return
	LDR r8, [r3]
	MOV r7, #0xA
	MUL r8, r7, r8
	ADD r5, r8, r2
	LDR r4, =0
	LDR r6, =4
	BX lr
return
	LDR r4, =0
	LDR r6, =0
	MOV r5, r2
	BX lr

flipInd
	MOV r4, #1 		;1 = prev was space // 0 = prev was num/op
	B endif2

addFn 
	STMFD r3!, {r0-r2,r4, lr}
	LDR r0, [r3, #4+20]
	LDR r1, [r3, #20]
	ADD r5, r1, r0
	LDR r6, =8
	LDMFD r3!, {r0-r2,r4, pc}
	
subFn 
	STMFD r3!, {r0-r2,r4, lr}
	LDR r0, [r3, #4+20]
	LDR r1, [r3, #20]
	SUB r5, r0, r1
	LDR r6, =8
	LDMFD r3!, {r0-r2,r4, pc}
	
mulFn 
	STMFD r3!, {r0-r2,r4, lr}
	LDR r0, [r3, #4+20]
	LDR r1, [r3, #20]
	MUL r5, r1, r0
	LDR r6, =8
	LDMFD r3!, {r0-r2,r4, pc}

divFn 
	STMFD r3!, {r0-r2, r4,lr}
	LDR r0, [r3, #4+20]
	LDR r1, [r3, #20]
	LDR r5, =0							;counter
	SUB r0, r0, r1
while4 
	CMP r0, #0x0
	BLT endwhile4
	ADD r5, r5, #0x1
	SUB r0, r0, r1
	B while4
endwhile4
	LDR r6, =8
	LDMFD r3!, {r0-r2,r4, pc}

powFn 
		STMFD r3!, {r0-r2,r4, lr}
		LDR r0, [r3, #4+20]
		LDR r1, [r3, #20]
		LDR r2, =0 						;counter
		LDR r5, =1
while2	
		CMP r2, r1
		BHS endwhile2
		MUL r5, r0, r5
		ADD r2, r2, #0x1
		B	while2
endwhile2
		LDR r6, =8
		LDMFD r3!, {r0-r2,r4, pc}

facFn 
		STMFD r3!, {r0-r2,r4, lr}
		LDR r0, [r3, #20]
		LDR r5, =1						;result
		CMP r0, #0x0
		BEQ endwhile3
		LDR r1, =1						;counter
while3
		CMP r0, r1
		BLS endwhile3
		MUL r5, r1, r5
		ADD r1, r1, #0x1
		B while3
endwhile3
		MUL r5, r1, r5
		LDR r6, =4
		LDMFD r3!, {r0-r2,r4, pc}

negFn 
	STMFD r3!, {r0-r2,r4, lr}
	LDR r0, [r3, #20]
	MOV r1, #0xFFFFFFFF
	EOR r0, r0, r1
	ADD r5, r0, #0x1
	LDR r6, =4
	LDMFD r3!, {r0-r2,r4, pc}
	
HexToVal
	STMFD r3!, {r0-r2,r4, lr}
	LDR r0, [r3, #8]
	SUB r5, r0, #0x30
	LDR r6, =0
	LDMFD r3!, {r0-r2,r4, pc}
	
endProg
	LDR r0, [r3], #4		;Pop value from Stack to result
stop	B	stop

	AREA	ReversePolish, DATA, READWRITE
rpnexp	DCB	"123 10 / ",0
	END
	
	END	