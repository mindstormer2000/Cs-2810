	;Square a number
	;Inputs: an integer placed into the input var
	;Outputs: The integer squared
	;Needed registers: r7,r6,r5
	.ORIG x3300

	AND R5,R5,#0	;Clear out the final register
	STI R7,RETURN	;Stores the return address for later use
	ST R2 INPUT	;Input is the contents of r2
	LD R7 INPUT	;Load the integer into r7
	LD R6 INPUT	;LOAD the integer into r6
	ADD R6,R6,#0
	BRzp MULTY
	NOT R2, R2
	ADD R2, R2, #-1
	NOT R7, R7
	ADD R7, R7, #-1
	NOT R6, R6
	ADD R6, R6, #-1
;
MULTY 	ADD R5,R5,R7	;ADD R7 TO R5
	ADD R6,R6,#-1	;DECREMENT R6
	BRp MULTY	;IF R6>0 GO TO MULTY

	ST R5 OUTPUT	;STORE R5 INTO OUTPUT
	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
	LD R2 OUTPUT	;Load the Output into R2
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