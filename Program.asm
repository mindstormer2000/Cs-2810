.ORIG x3500    ; start address in memory
;Output format
START	LEA R0, EXAMP
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
;Clear all
	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
;Subtract x1 and x2
	LD	R1	XONE
	LD	R2	XTWO
	NOT	R1	R1
	ADD	R1	R1	#1
	ADD	R2	R1	R2
	BRzp	STILLPx
	NOT	R2	R2
	ADD	R2	R2	#1
;Square 
STILLPx	LD	R7	SQUARE
	JSRR	R7
	ST	R2	XSQ

;Subtract y1 and y2
	LD	R1	YONE
	LD	R2	YTWO
	NOT	R1	R1
	ADD	R1	R1	#1
	ADD	R2	R1	R2
	BRzp	STILLPy
	NOT	R2	R2
	ADD	R2	R2	#1
;Square 
STILLPy	LD	R7	SQUARE
	JSRR	R7
	ST	R2	YSQ
;Clear all
	AND 	R0,	R5,	#0
	AND 	R1,	R5,	#0
	AND 	R2,	R5,	#0
	AND 	R3,	R5,	#0
	AND 	R4,	R5,	#0
	AND 	R5,	R5,	#0
	AND 	R6,	R5,	#0
	AND 	R7,	R5,	#0
;ADD YSQ andXSQ
	LD	R1	XSQ
	LD	R2	YSQ
	ADD	R3	R2	R1
;SQUARE ROOT
	LD	R7	ROOT
	JSRR	R7
;Output it
	LD	R7	OUTPUT
	JSRR	R7
;R0 is input
;R1 is input copy
;R2 is the test ascii code
;R3 is the total of the above
;AGAIN? 
LOOP	LEA	R0 	AGAIN
	PUTS
	GETC
	ADD	R1	R0	#0
	LD	R2	ASCIIN
	ADD	R3	R1	R2
	BRz	DONE
	ADD	R1	R0	#0
	LD	R2	ASCIIn
	ADD	R3	R1	R2
	BRz	DONE
	ADD	R1	R0	#0
	LD	R2	ASCIIY
	ADD	R3	R1	R2
	BRz	START
	ADD	R1	R0	#0
	LD	R2	ASCIIy
	ADD	R3	R1	R2
	BRz	START
	LEA	R0	ERROR
	PUTS
	BRNZP	LOOP

DONE	Halt    ; stop the program
;Variables
XONE	.FILL	#0
XTWO	.FILL	#0
YONE	.FILL	#0
YTWO	.FILL	#0
XSQ	.FILL	#0
YSQ	.FILL	#0
INSIDE	.FILL	#0
OUTSIDE	.FILL	#0
ASCIIN	.FILL	#-78
ASCIIn	.FILL	#-110
ASCIIY	.FILL	#-89
ASCIIy	.FILL	#-121
PROMPT	.FILL	x3100
SQUARE	.FILL	x3300
ROOT	.FILL	x3200
OUTPUT	.FILL	x3400
EXAMP	.STRINGZ "The format we are using for finding the distance is as follows\n SQRT((x2-x1)^2+(y2-y1)^2)\n"
XONEP	.STRINGZ "\nPlease input X1"
XTWOP	.STRINGZ "\nPlease input X2"
YONEP	.STRINGZ "\nPlease input Y1"
YTWOP	.STRINGZ "\nPlease input Y2"
AGAIN	.STRINGZ "\nWould You like to do go again? (Y or N)"
ERROR	.STRINGz "\nINVALID KEY:"
DASH	.STRINGz "\n\n\n________________________________________________________\n\n\n"
.END

