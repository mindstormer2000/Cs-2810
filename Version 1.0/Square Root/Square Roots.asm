;This is the squareroot with factoring
;Created by Dayson and Caiden
;Inputs R3 = Inside
;output R3 = Outside, R4 = Inside
;Division inputs: Divided = R3, Divisor = R2 and outputs the total to R2 and the Remainder to R3. Uses ALL REGISTERS


.ORIG x3200
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
START	LD  	R3 	INSIDE
	LD	R2	DIVISOR
	LD	R7	DIVJUMP
	JSRR	R7
	ADD	R3	R3	#0
	BRnp	UPONE
	ST 	R2 	TESTTWO
	LD	R3	TESTTWO
	LD	R2	DIVISOR
	LD	R7	DIVJUMP
	JSRR	R7
	ADD	R3	R3	#0
	BRnp	UPONE
	ST	R2	INSIDE
	LD	R2	OUTSIDE	
	LD	R1	DIVISOR	;counter
	AND	R4	R4	#0
MULTY	ADD	R4	R4	R2
	ADD	R1	R1	#-1
	BRp	MULTY
	ST	R4 	OUTSIDE
	BRNZP	TEST

UPONE	LD	R1	DIVISOR
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

	HALT

DIVJUMP	.FILL	x3000				;Address to jump to the division code.
SQRJUMP	.FILL	x2000				;Address to jump to the squaring code.
INSIDE	.FILL 	#1
DIVISOR	.FILL	#2
OUTSIDE	.FILL	#1
TESTTWO	.FILL	#1
OOPS   .STRINGZ	"An error has occurred!"
.END

