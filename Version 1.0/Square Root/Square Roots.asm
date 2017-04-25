;This is the squareroot with factoring
;Created by Dayson and Caiden
;Inputs R3 = Inside
;output R3 = Outside, R4 = Inside
;Division inputs: Divided = R3, Divisor = R2 and outputs the total to R2 and the Remainder to R3. Uses ALL REGISTERS


.ORIG x3200
	ST	R7	JUMPER
	ST 	R3, INSIDE
	ADD	R3	R3	#0
	BRnz	ZERO
	ADD	R3	R3	#-1
	BRz 	ONE
	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
	ADD	R7	R7,	#1
	ST	R7	OUTSIDE
	ADD	R7	R7,	#1
	ST	R7	DIVISOR
	AND 	R7,	R5,	#0
	;ALL registers a cleared out
START	LD  	R3 	INSIDE		;Load I
	LD	R2	DIVISOR		;Load n
	LD	R7	DIVJUMP		
	JSRR	R7			;Divide the I/n
	ADD	R3	R3	#0	;Grab Remainder
	BRnp	UPONE			;Check if (I/n) = 0
	ADD	R2	R2	#-1
	BRz	GOBACK		;check if (I/n) = 1
	ADD	R2	R2	#1
	ST 	R2 	TESTTWO		;store I/n into F
	LD	R3	TESTTWO		;Load F
	LD	R2	DIVISOR		;Load n
	LD	R7	DIVJUMP		
	JSRR	R7			;Divide the F/n
	ADD	R3	R3	#0
	BRnp	UPONE			;Check if (F/n) = 0
	ST	R2	INSIDE		;I = (F/n)
	LD	R2	OUTSIDE		;
	LD	R1	DIVISOR		;counter
	AND	R4	R4	#0
MULTY	ADD	R4	R4	R2
	ADD	R1	R1	#-1
	BRp	MULTY
	ST	R4 	OUTSIDE
	BRNZP	TEST
	
UPONE	LD	R1	DIVISOR		;Increment divisor
	ADD	R1	R1	#1
	ST	R1	DIVISOR

	BRNZP	TEST
TEST	LD	R1	DIVISOR
	LD	R2	INSIDE
	NOT	R1	R1
	ADD	R1	R1	#1
	ADD	R3	R1	R2
	BRnz	GOBACK
	BRp	START

ONE	AND	R1,	R5	#0
	ST	R1	INSIDE
	ADD	R1	R1	#1
	St	R1	OUTSIDE
	BRnzp	GOBACK

ZERO	AND 	R1,	R5,	#0
	ST	R1	INSIDE	
	ST	R1	OUTSIDE
		
GOBACK	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
	LD 	R4, 	INSIDE
	LD	R3,	OUTSIDE
	LD	R7	JUMPER
	RET
	HALT

DIVJUMP	.FILL	x3000				;Address to jump to the division code.
SQRJUMP	.FILL	x2000				;Address to jump to the squaring code.
INSIDE	.FILL 	#1
DIVISOR	.FILL	#2
OUTSIDE	.FILL	#1
TESTTWO	.FILL	#1
JUMPER	.FILL	x0000
OOPS   .STRINGZ	"An error has occurred!"
.END

