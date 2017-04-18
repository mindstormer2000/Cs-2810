.ORIG x3400
	;Fix Maxdiv
	LD	R1 	MAXDIVs
	ST	R1	MAXDIV
	;Store all the vars coming out of sqareroot
	ST	R3	TOTAL
	ST	R4	INSIDE
	ST	R7	JUMPER
	LEA	R0	ANSWER
	PUTS
;check to see if sqrt is zero
	ADD	R4,	R4	#0
	BRnz	OUTCH
	
;Check to see if there is a number in the hundreds collumn
	LD 	R3	TOTAL
	LD	R2	HUND
	LD 	R7	DIVI
	JSRR 	R7
	;STORE REMAINDER
	ST 	R3,	REM
	ADD	R2,	R2,	#0
	BRnz	NZ
	;ADD ASCII CHANGER
	LD 	R4	ASCII
	ADD 	R0,	R2,	R4
	OUT
;Tens column
NZ	LD 	R3	REM
	LD	R2	TENS
	LD 	R7	DIVI
	JSRR 	R7
	;STORE REMAINDER
	ST 	R3,	REM
	ADD	R2,	R2,	#0
	BRnz	NTZ
	;ADD ASCII CHANGER
	LD 	R4	ASCII
	ADD 	R0,	R2,	R4
	OUT
;Output the last number
NTZ	LD 	R0	REM
	LD 	R4	ASCII
	ADD 	R0,	R0,	R4
	OUT
;OUTPUT THE SQAREROOT REMAINDER
	;Clear all registers
	AND R0,R5,#0
	AND R1,R5,#0
	AND R2,R5,#0
	AND R3,R5,#0
	AND R4,R5,#0
	AND R5,R5,#0
	AND R6,R5,#0
	AND R7,R5,#0
	;CHECK TO SEE IF SQUAREROOT IS NEEDED
	LD 	R1	INSIDE
	ADD	R1	R1	#-1
	BRnz	END
	LEA	R0	SQRT
	PUTS
LOOP	LD	R2	MAXDIV
	LD	R3	INSIDE
	LD	R7	DIVI
	JSRR	R7
	ST	R3	INSIDE
	ADD	R2	R2	#0
	BRnz	SNZ
	LD 	R4	ASCII
	ADD 	R0,	R2,	R4
	OUT
SNZ	LD	R3	MAXDIV
	LD	R2	TENS
	LD	R7	DIVI
	JSRR	R7
	ADD	R3	R3	#-1
	BRz	SFIN
	ST	R2	MAXDIV
	BRnzp	LOOP
OUTCH	ADD	R3,	R3	#0
	BRnz	OUTZERO
	BRp	OUTONE
OUTZERO	LD 	R0	ASCII
	OUT
	BRnzp	END
OUTONE	LD	R0	ASCII
	ADD	R0	R0	#1
	OUT
	BRnzp	END
SFIN	LEA 	R0	CBRAKET
	PUTS
	BRnzp	END
END	LD	R7	JUMPER
	
	RET
	HALT
;VARS
ONES 	.FILL 	#1
TENS	.FILL	#10
HUND	.FILL	#100
MAXDIV	.FILL	#10000
MAXDIVs	.FILL	#10000
DIVI	.FILL	x3000
JUMPER	.FILL	x0000
TOTAL	.FILL	#0
INSIDE	.FILL	#0
REM	.FILL	#0
DIV	.FILL	#0
ASCII	.FILL	#48
SQRT	.STRINGZ	"SQRT("
ANSWER	.STRINGZ	"\nThe answer is = "
CBRAKET	.STRINGZ	")."
.END