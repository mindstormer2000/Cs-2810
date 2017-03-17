	;Square a number
	;Inputs: an integer placed into the input var
	;Outputs: The integer squared
	;Needed registers: r7,r6,r5
	.ORIG x0000

	AND R5,R5,#0	;Clear out the final register
	LD R7 INPUT	;Load the integer into r7
	LD R6 INPUT	;LOAD the integer into r6

MULTY 	ADD R5,R5,R7	;ADD R7 TO R5
	ADD R6,R6,#-1	;DECREMENT R6
	BRp MULTY	;IF R6>0 GO TO MULTY

	ST R5 OUTPUT	;STORE R5 INTO OUTPUT
	LD R5 PCJUMP	;Load into R5 the area where the code should go after running
	JMP R5		;Go to that area
	HALT		;STOP
	INPUT .FILL #0
	OUTPUT .FILL #0
	PCJUMP .FILL x0000
	; |\
	; | \ z
	;y|  \
	; |___\
	;   x
	;
	.END