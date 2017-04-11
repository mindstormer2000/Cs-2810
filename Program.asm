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
	ADD R2, R1, R2
	LD R6, SQUARE
	JSRR R6
	ST R3, XSQ
;Subtract y1 from y2
	;Twos complement y1
	LD R3, YONE
	NOT R3, R3
	ADD R3, R3, #1
	;Add -y1 to y2
	LD R4 YTWO
	ADD R2, R3, R4
	LD R6, SQUARE
	JSRR R6
	ST R3, YSQ
;Clear all registers
	AND R0,R5,#0
	AND R1,R5,#0
	AND R2,R5,#0
	AND R3,R5,#0
	AND R4,R5,#0
	AND R5,R5,#0
	AND R6,R5,#0
	AND R7,R5,#0
;Load needed inputs
	LD R1, XSQ
	LD R2, YSQ
	ADD R0, R1, R2
;Square root above answer
	LD R7 ROOT
	JSRR R7
;Save stuff that comes back
	ST R0 FIN
;Output answer
	

DONE	Halt    ; stop the program
;Variables
XONE	.FILL	#0
XTWO	.FILL	#0
YONE	.FILL	#0
YTWO	.FILL	#0
XSQ	.FILL	#0
YSQ	.FILL	#0
FIN	.FILL	#0
PROMPT	.FILL	x3100
SQUARE	.FILL	x3300
ROOT	.FILL	x3200
EXAMP	.STRINGZ "The format we are using for finding the distance is as follows\n SQRT((x2-x1)^2+(y2-y1)^2)\n"
XONEP	.STRINGZ "Please input X1"
XTWOP	.STRINGZ "Please input X2"
YONEP	.STRINGZ "Please input Y1"
YTWOP	.STRINGZ "Please input X1"
.END

