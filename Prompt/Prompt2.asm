
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

	LEA	R0, PRMT	; "Enter a number from 0 to 180: "
	PUTS
	AND R4,R4,#0

GETNUM	GETC			; get the first character entered by the user (first digit)
	ADD	R1, R0, 0	; put the first digit in R1
	ADD	R1, R1, #-10	; if ((R1 - 10) == 0), or if R1 == newline
	BRz	EXIT
	ADD	R1, R1, #10	; if ((R1 - 10) == 0), or if R1 == newline
	JSRR 	CHECK
	ADD R1, R1, #-48
	JSRR TIMESTE
	ADD R4,R4, R1
	ADD R5,R5,#-3
	BRnz GOBACK

	;Uses r1, r2, r3
CHECK	ADD R2, R1, #-48	;Check to see if below ascii numbers
	BRn ERROR
	ADD R2, R1, #-57	;Check to see if above ascii numbers
	BRp ERROR
	RET
	
ERROR	LEA R0,EMESG
	PUTS
	JMP BACK

	;uses R4 r2 r3
	;Takes r1 times 10
TIMESTE	ADD R2, R4, #0
	ADD R3, #0,#10
	ADD R4,R4,R2
	ADD R3, R3,#-1
	BRp TIMESTE
	RET

EXIT	ADD R5, R5,#0
	BRz ERROR

GOBACK	LD R7, JUMPER
	RET
HALT
JUMPER	.FILL	#O
PRMT	.stringz "\nEnter a number from 0 to 180: "
EMESG	.stringz "\nERROR:That is not valid input"



	.END