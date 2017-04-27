.ORIG x3500    ; start address in memory
;Output format
START	LEA R0, EXAMP
	PUTS                    ;Display "The format we are using ....."

;Get X1
	LEA R0, XONEP
	PUTS                    ;Display "Please input X1"
	LD R6, PROMPT
	JSRR R6                 ;Read number
	ST R3, XONE             ;Store X1
;Get Y1
	LEA R0, YONEP
	PUTS                    ;Display "Please input Y1"
	LD R6, PROMPT
	JSRR R6                 ;Read number
	ST R3, YONE             ;Store Y1
;Get X2
	LEA R0, XTWOP
	PUTS                    ;Display "Please input X2"
	LD R6, PROMPT
	JSRR R6                 ;Read number
	ST R3, XTWO             ;Store X2
;Get Y2
	LEA R0, YTWOP
	PUTS                    ;Display "Please input Y2"
	LD R6, PROMPT
	JSRR R6                 ;Read number
	ST R3, YTWO             ;Store Y2
;Clear all registers
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
	ADD	R1	R1	#1          ;r1 = -r1
	ADD	R2	R1	R2          ;r2 = r2 - r1
	BRzp	STILLPx         ;if r2 >= 0 goto stillpx
	NOT	R2	R2
	ADD	R2	R2	#1          ;r2 = -r2
;Square
STILLPx	LD	R7	SQUARE
	JSRR	R7              ;r2 = r2 * r2
	ST	R2	XSQ             ;xsq = (x1-x2)*(x1-x2)

;Subtract y1 and y2
	LD	R1	YONE
	LD	R2	YTWO
	NOT	R1	R1
	ADD	R1	R1	#1          ;r1 = -r1
	ADD	R2	R1	R2          ;r2 = r2 - r1
	BRzp	STILLPy         ;if r2 >= 0 goto stillpy
	NOT	R2	R2
	ADD	R2	R2	#1          ;r2 = -r2
;Square
STILLPy	LD	R7	SQUARE
	JSRR	R7              ;r2 = r2 * r2
	ST	R2	YSQ             ;ysq = (y1-y2)*(y1-y2)
;Clear all registers
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
	ADD	R3	R2	R1          ;r3 = xsq + ysq
;SQUARE ROOT
	LD	R7	ROOT
	JSRR	R7              ;r3 = squareroot(r3)
;Output it
	LD	R7	OUTPUT
	JSRR	R7              ;display number
;R0 is input
;R1 is input copy
;R2 is the test ascii code
;R3 is the total of the above
;AGAIN?
LOOP	LEA	R0 	AGAIN
	PUTS                       ;Display "Would You like to do go again? (Y or N)"
	GETC                    ;read a character
	ADD	R1	R0	#0          ;copy r0 to r1
	LD	R2	ASCIIN
	ADD	R3	R1	R2
	BRz	DONE                ;if 'N' entered goto DONE
	ADD	R1	R0	#0
	LD	R2	ASCIIn
	ADD	R3	R1	R2
	BRz	DONE                ;if 'n' entered goto DONE
	ADD	R1	R0	#0
	LD	R2	ASCIIY
	ADD	R3	R1	R2
	BRz	GAIN                ;if 'Y' entered goto GAIN
	ADD	R1	R0	#0
	LD	R2	ASCIIy
	ADD	R3	R1	R2
	BRz	GAIN                ;if 'y' enter goto GAIN
	LEA	R0	ERROR
	PUTS                    ;display "INVALID KEY:"
	BRNZP	LOOP            ;go back and get Y/N again
GAIN	LEA	R0	DASH
	PUTS                    ;display "______________________..."
	BRnzp	START           ;go back and ask for x1, and others again
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
PROMPT	.FILL	x3100           ;Prompt subroutine
SQUARE	.FILL	x3300           ;Square subroutine
ROOT	.FILL	x3200           ;Square root subroutine
OUTPUT	.FILL	x3400           ;Output subroutine
EXAMP	.STRINGZ "\n\nThe format we are using for finding the distance is as follows\n SQRT((x2-x1)^2+(y2-y1)^2)\n"
XONEP	.STRINGZ "\n\nPlease input X1"
XTWOP	.STRINGZ "\n\nPlease input X2"
YONEP	.STRINGZ "\n\nPlease input Y1"
YTWOP	.STRINGZ "\n\nPlease input Y2"
AGAIN	.STRINGZ "\n\nWould You like to do go again? (Y or N)"
ERROR	.STRINGz "\nINVALID KEY:"
DASH	.STRINGz "\n\n\n________________________________________________________\n\n\n"
.END

