.ORIG x3400    ; start address in memory
;Output format
	LEA R0, EXAMP
	PUTS

;Get X1
	LEA R0, XONEP
	PUTS
	LD R6, PROMPT
	JSRR R6
	ST R3, XONE
;Get Y1
	LEA R0, YONEP
	PUTS
	LD R6, PROMPT
	JSRR R6
	ST R3, YONE
;Get X2
	LEA R0, XTWOP
	PUTS
	LD R6, PROMPT
	JSRR R6
	ST R3, XTWO
;Get Y2
	LEA R0, YTWOP
	PUTS
	LD R6, PROMPT
	JSRR R6
	ST R3, YTWO
;Subtract x1 from x2
	;Twos complement x1
	LD R1, XONE
	NOT R1, R1
	ADD R1, R1, #1
	;Add -x1 to x2
	LD R2 XTWO
	ADD R5, R1, R2
	
;Square above items
;Subtract y1 from y2
;Square above items
;Add the above squares
;Square root above answer
;Output answer

DONE	Halt    ; stop the program
;Variables
XONE	.FILL	#0
XTWO	.FILL	#0
YONE	.FILL	#0
YTWO	.FILL	#0
PROMPT	.FILL	x3100
EXAMP	.STRINGZ "The format we are using for finding the distance is as follows\n SQRT((x2-x1)^2+(y2-y1)^2)\n"
XONEP	.STRINGZ "Please input X1"
XTWOP	.STRINGZ "Please input X2"
YONEP	.STRINGZ "Please input Y1"
YTWOP	.STRINGZ "Please input X1"
.END

