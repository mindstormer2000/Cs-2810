.ORIG x3200	
	
LOOP ;Store the return address for later use
	STI R7, RETURN
	LD R2 DIVDER 
	LD R3 RADICA
	LD R7 DIVISI
	JSRR R7
	
HALT
ANSWER 	.FILL #0
REMAIN	.FILL #0
RADICA	.FILL #0
DIVDER	.FILL #2
DIVISI	.FILL x3000
RETURN	.FILL x4000
OUTRO 	.STRINGZ "The square root has been found!"
WRONG	.STRINGZ "Error: Cannot square root a negative number."

.END

