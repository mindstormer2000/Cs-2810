.ORIG x3200	
 ;Store the return address for later use
	STI R7, RETURN
	ST R3, ABOVE
LOOP	LD R2, ABOVE
	LD R3, BELOW
	LD R7, DIVISI
	JSRR R7
	LD R1, BELOW
	NOT R1, R1
	ADD R1, R1, #-1
	ADD R4,R1, R2
	BRz EQU
	Brn ABVE
	BRp BELO
;Check to see if equal above or below
ABVE	LD R2 ABOVE	;encrement above
	ADD R3, R2,#-1
	BRnzp LOOP

BELO	LD R2 ABOVE	;Increment below
	ADD R3, R2,#1
	
	BRnzp LOOP
EQU	
	AND R0,R5,#0
	AND R1,R5,#0
	AND R2,R5,#0
	AND R3,R5,#0
	AND R4,R5,#0
	AND R5,R5,#0
	AND R6,R5,#0
	AND R7,R5,#0
	LDI R7 RETURN	;Load into R7 the area where the code should go after running
	RET
	
HALT

ABOVE	.FILL #0
BELOW	.FILL #706
DIVISI	.FILL x3000
RETURN	.FILL x3400
OUTRO 	.STRINGZ "The square root has been found!"
WRONG	.STRINGZ "Error: Cannot square root a negative number."
;ABOVE
;----- = division
;BELOW
;
.END

