	;Square a number
	;Inputs: an integer placed into the input var
	;Outputs: The integer squared
	;Needed registers: r7,r6,r5
	.ORIG x2000

	AND R5,R5,#0	;Clear out the final register
	STI R7,RETURN	;Stores the return address for later use
	ST R2 INPUT	;Input is the contents of r2
	LD R7 INPUT	;Load the integer into r7
	LD R6 INPUT	;LOAD the integer into r6

MULTY 	ADD R5,R5,R7	;ADD R7 TO R5
	ADD R6,R6,#-1	;DECREMENT R6
	BRp MULTY	;IF R6>0 GO TO MULTY

	ST R5 OUTPUT	;STORE R5 INTO OUTPUT
	LD R3 OUTPUT	;In a move of comical inefficiency, immediately pulls output back into R3 because I know how variables work
	LDI R7 RETURN	;Load into R7 the area where the code should go after running
	RET		;Go to that area
	HALT		;STOP
	INPUT .FILL #0
	OUTPUT .FILL #0
	RETURN	.FILL x4004
	PCRTRN .FILL x0000
	; |\
	; | \ z
	;y|  \
	; |___\
	;   x
	;
	.END