	;This program takes two numbers and divides them.
	;this edit is made for kaya to test
	;The outputs will be put into the memory at two different locations
	;Outputs: Remainder, Answer
	;Inputs: Divided, Divisor
	.ORIG x0000
;Clear out the final register
	AND R5,R5,#0
;Store the return address for later use
	STI R7, RETURN
;Load the two inputs
	ST R3 DIVIDED	;Push R3, the divided into DIVIDED
	LD R7 DIVISOR	;Load the integer into r7
	LD R6 DIVIDED	;LOAD the integer into r6
;Check to see if the number being divided is zero	
	ADD R7, R7, #0
	BRz ZERO
;Check to see if the Divisor is negative
	ADD R6, R6, #0
	;Divide the two
	BRn NEG
	BRp POS
	BRz ZERO

;Division if the one being divided is positive
POS	ADD R7, R7, #0
	BRn LOOPPOS
	NOT R7, R7
	ADD R7, R7, #1

LOOPPOS
	ADD R6, R6,R7	;Subtract the divisor from divided
	BRn FINALP	;Check to see if negative
	ADD R5, R5, #1	;If not negative add 1 to R5
	BRnzp LOOPPOS	;Loop again
FINALP	NOT R7, R7	;Twos complement
	ADD R7, R7, #1	;Twos complement
	ADD R6, R6, R7	;Go back to the time when it was positive
	ST R5 TOTAL	;Store the final total
	ST R6 REMDER	;Store the remainder
	BRnzp JUMP

NEG	ADD R7, R7, #0
	BRp LOOPNEG
	NOT R7, R7
	ADD R7, R7, #1

LOOPNEG	ADD R6, R6,R7	;Subtract the divisor from divided
	BRp FINALN	;Check to see if negative
	ADD R5, R5, #1	;If not negative add 1 to R5
	BRnzp LOOPPOS	;Loop again

FINALN	NOT R7, R7	;Twos complement
	ADD R7, R7, #1	;Twos complement
	ADD R6, R6, R7	;Go back to the time when it was negative
	NOT R6, R6	;Twos complement
	ADD R6, R6, #1	;Twos complement
	ST R5 TOTAL	;Store the final total
	ST R6 REMDER	;Store the remainder
	BRnzp JUMP

;If the number being divided is zero
ZERO	ST R6 REMDER
	ST R6 TOTAL
	BRnzp JUMP
;Jump back to the position in PCJUMP VAR
JUMP	LDI R7 RETURN	;Load into R7 the area where the code should go after running
	LD  R2 TOTAL	;Put total into R2 because I cannot for the life of me figure out cross-code variable storage
	RET		;Returns to the line after the one that called the Division code	
;All the variables
	HALT
;Inputs
DIVISOR	.FILL #2
DIVIDED	.FILL #10
;Outputs
REMDER	.FILL #1
TOTAL	.FILL #3
RETURN	.FILL x4000
			;PCJUMP	.FILL x0000 - No longer necessary with RETURN
	.END