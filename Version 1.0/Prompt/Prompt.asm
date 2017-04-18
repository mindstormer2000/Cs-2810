
	.ORIG	x3100

	; User input example: 123 = 49, 50, 51 = 0000000000110001, 0000000000110010, 0000000000110011
	; R1 = (49-48) * 100 = 1 * 100
	; R2 = (50-48) * 10  = 2 * 10
	; R3 = (51-48) 	     = 3
	; Input: 123 as separate characters
	; Postcondition: input = (1 * 100) + (2 * 10) + 3 = 123 as an actual number (0000000001111011).
	; newline: lf, 10

	; R1 = DIGIT
	; R2 = USED FOR MANY PURPOSES
	; R3 = USED FOR MANY PURPOSES
	; R4 = FINAL digit
	; R5 = digit count
	; R6 = final result
	ST	R7, JUMPER

STRT	LEA	R0, PRMT	; "Enter a number from 0 to 180: "
	PUTS
	AND R6,R6,#0

GETNUM	GETC			; get the character entered by the user (first digit)
	ADD	R1, R0, 0	; put the digit in R1
	ADD	R1, R1, #-10	; if ((R1 - 10) == 0), or if R1 == newline
	BRz	EXIT
	ADD	R1, R1, #10	; if ((R1 - 10) == 0), or if R1 == newline
	LEA 	R7, CHECK
	JSRR 	R7
	ADD	R0, R1, #0
	OUT
	LD 	R2, ASCIIB
	ADD 	R1, R1, R2
	LEA 	R7, TIMEST
	JSRR 	R7
	ADD 	R6,R6, R1
	ADD 	R5,R5,#-2
	BRzp 	CKTWO
	ADD	R5, R5, #3
	BRnzp	GETNUM

	;Uses r1, r2, r3
CHECK	LD 	R2, ASCIIB
	ADD 	R2, R2, R1		;Check to see if below ascii numbers
	BRn 	ERROR
	LD 	R2, ASCIIA
	ADD 	R2, R2, R1		;Check to see if above ascii numbers
	BRp 	ERROR
	RET

CKTWO	LD	R2, MAX
	ADD 	R2, R2, R6
	BRnz	GOBACK
	LEA 	R0,EMESG
	PUTS
	BRnzp	STRT
	
ERROR	LEA 	R0,EMESG
	PUTS
	LEA	R7, GETNUM
	JMP 	R7

	;uses R4 r2 r3
	;Takes r1 times 10
TIMEST	AND 	R3, R3, #0
	ADD	R3, R3, #9
	ADD 	R2, R6, #0
TIMESTE	ADD 	R6,R6,R2
	ADD 	R3, R3,#-1
	BRp 	TIMESTE
	RET

EXIT	ADD 	R5, R5,#0
	BRz 	ERROR

GOBACK	ST 	R6  STORAGE
	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
	LD	R3	STORAGE
	LD 	R7, JUMPER
	RET
HALT
STORAGE	.FILL	#0
JUMPER	.FILL	x0000
ASCIIB	.FILL	#-48
ASCIIA	.FILL	#-57
MAX	.FILL	#-180
PRMT	.stringz "\nEnter a number from 0 to 180: "
EMESG	.stringz "\nERROR:That is not valid input"



	.END