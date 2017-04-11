
	.ORIG	x3100

	
	; JUST TO MAKE THINGS CLEAR AND SIMPLE...
	; User input example: 123 = 49, 50, 51 = 0000000000110001, 0000000000110010, 0000000000110011
	; R1 = (49-48) * 100 = 1 * 100
	; R2 = (50-48) * 10  = 2 * 10
	; R3 = (51-48) 	     = 3
	; Input: 123 as separate characters
	: Postcondition: input = (1 * 100) + (2 * 10) + 3 = 123 as an actual number (0000000001111011)


	LEA	R0, PRMT	; "Enter a number from 0 to 256: "
	PUTS

	GETC			; get the first character entered by the user (first digit)
	OUT			; output character as it's being typed
	ADD	R1, R0, 0	; put the first digit in R1
	ADD	R1, R1, -48	; translates the character into an integer
	ADD	R4, R4, #1	; increment R4 for digit count (1)

	GETC			; get the second character entered by the user (second digit)
	OUT			; output character as it's being typed
	ADD	R2, R0, 0	; put the second digit in R2
	ADD	R2, R2, -48	; translates the character into an integer
	ADD	R4, R4, #1	; increment R4 for digit count (2)

	GETC			; get the third character entered by the user (third digit)
	OUT			; output the character as it's being typed
	ADD	R3, R0, 0	; put the third digit in R3
	ADD	R3, R3, -48	; translates the character into an integer
	ADD	R4, R4, #1	; increment R4 for digit count (3)


	; This is the part where 2-3 characters becomes a 2-3 digit number

	; If R4 is 1 when enter key pressed, R5 = R1
	; If R4 is 2 when enter key pressed, R5 = (R1 * 10) + R2
	; If R4 is 3 when enter key pressed, R5 = (R1 * 100) + (R2 * 10) + R3

	; if (R4 == 1)************************************************

	ADD	R4, R4, #-1		; if ((R4 - 1) == 0)
	BRz	ONE_DIGIT
	; BRz	ONED			; "The number is one digit" for test

ONE_DIGIT
	ADD	R5, R5, R1		; R5 = R1

	; if (R4 == 2)************************************************

	ADD	R4, R4, #-2		; if ((R4 - 2) == 0)
	BRz	TWO_DIGIT_R1x10
	; BRz	TWOD			; "The number is two digits" for test

TWO_DIGIT_R1x10				; (R1 * 10)
	ADD	R1, R1, #1		; do {R2++}
	LD	R0, #-10		; load -10 into R0
	ADD	R1, R1, R0		; compute R1 - 10
	BRn	TWO_DIGIT_R1x10		; while (R1 < 10)

	ADD	R5, R1, R2		; R5 = (R1 * 10) + R2

	; if (R4 == 3)************************************************

	ADD	R4, R4, #-3	; if ((R4 - 3) == 0)
	BRz	THREE_DIGIT_R1x100
	BRz	THREE_DIGIT_R2x10
	; BRz	THREED			; "The number is three digits" for test

THREE_DIGIT_R1x100			; (R1 * 100)
	ADD	R1, R1, #1		; do {R1++}
	LD	R0, #-100		; load -100 into R0
	ADD	R1, R1, R0		; compute R1 - 100
	BRn	THREE_DIGIT_R1x100	; while (R1 < 100)

THREE_DIGIT_R2x10			; (R2 * 10)
	ADD	R2, R2, #1		; do {R2++}
	LD	R0, #-10		; load -10 into R0
	ADD	R2, R2, R0		; compute R2 - 10
	BRn	THREE_DIGIT_R2x10	; while (R2 < 10)

	ADD	R0, R1, R2		; R5 = (R1 * 100) + (R2 * 10) + R3
	ADD	R5, R0, R3

	HALT




PRMT	.stringz "\nEnter a number from 0 to 256: "
RSLT	.stringz "\nThe number you entered is "

ONED	.stringz "\nThe number is one digit long"
TWOD	.stringz "\nThe number is two digits long"
THREED	.stringz "\nThe number is three digits long"

pONE	.FILL	49

	.END