	;This program takes two numbers and divides them.
	;The outputs will be put into the memory at two different locations
	;Outputs: Remainder(r3), Answer(r2)
	;Inputs: Divided(R3), Divisor(r2)
	.ORIG x3000
;Store the return address for later use
	STI R7, RETURN
;Load the two inputs
	ST R3 DIVIDED	;Push R3, the divided into DIVIDED
	ST R2 DIVISOR	;Push r2 into the divisor
;Clear out the registers 
	AND R0,R5,#0
	AND R1,R5,#0
	AND R2,R5,#0
	AND R3,R5,#0
	AND R4,R5,#0
	AND R5,R5,#0
	AND R6,R5,#0
	AND R7,R5,#0
;LOAD NEEDED ITEMS
	LD R7 DIVISOR	;Load the integer into r7
	LD R6 DIVIDED	;LOAD the integer into r6
;Check to see if the number being divided is zero	
	ADD R7, R7, #0
	BRz ZERO
	ADD R6, R6,#0
	BRz ZERO
;Numbers input will be positive
	NOT R7, R7;Subtract off divisor
	ADD R7,R7,#1
LOOP	ADD R6, R6,R7
	;Check if negative
	BRn FIN
	;If not increment and go back to the top
	ADD R1, R1, #1
	BRnzp LOOP

FIN	ST R1, TOTAL
	NOT R7, R7;
	ADD R7,R7,#1
	ADD R5, R6,R7
	ST R5, REMDER
	BRnzp JUMP



;If the number being divided is zero
ZERO	ST R6 REMDER
	ST R6 TOTAL
	BRnzp JUMP
;Jump back to the position in PCJUMP VAR
JUMP	AND R0,R5,#0
	AND R1,R5,#0
	AND R2,R5,#0
	AND R3,R5,#0
	AND R4,R5,#0
	AND R5,R5,#0
	AND R6,R5,#0
	AND R7,R5,#0
	LDI R7	RETURN
	LD  R2	TOTAL	;Put total into R2
	LD  R3	REMDER	;Put Rembdr into R3
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
				.END