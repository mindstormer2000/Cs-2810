
	; Here's the solution for getting double digit results. I don't know how to get inputs of more than one digit however
	; I also don't quite know what to input into the other functions and where they go
	; Hopefully these instructions are a little help

	.ORIG	x3000

	; These instructions are the promting part of the program where the user enter the values
	; For now, they're just single digit values

	LEA	R0, PRMT1	; "Enter the value for point A from 0 to 256: "
	PUTS
	GETC			; get first number
	OUT			; print entered character in R0
	ADD	R1, R0, 0	; put the first number in R1

	LEA	R0, PRMT2	; "Enter the value for point B from 0 to 256: "
	PUTS
	GETC			; get second number
	OUt			; print entered character in R0
	ADD	R2, R0, 0	; put the second number in R2

	LEA	R0, RSLT	; "The distance between the two points is "

	; use function for distance calculator		TEST WITH ADDING: ADD R0, R2, R1

	; These instructions are the tricky part, this is how the result can print more than two digits.
	; I tested this by adding two numbers and it worked, but that's all I have so far

	LD	R3, nONE	; load -48 into R3
	ADD	R0, R0, R3	; subtract 48 to get ASCII value, put it in R0

	LD	R4, nNINE	; load -57 into R4
	ADD	R1, R0, R4	; subtract 57 to get ASCII value, put it in R1

	BRnz	DONE		; if the answer is a single digit, print
	ADD	R2, R0, 0	; else, store the digits in R2

	LD	R0, pONE	; get 1
	OUT

	ADD	R0, R2, -10	; get the second digit
DONE	OUT

	HALT

PRMT1	.stringz "\nEnter the value for point A from 0 to 256: "
PRMT2	.stringz "\nEnter the value for point B from 0 to 256: "
RSLT	.stringz "\nThe distance between the two points is "

nONE	.FILL	-48	; the ASCII value for -1
nNINE	.FILL	-57	; the ASCII value for -9
pONE	.FILL	49	; the ASCII value for 1

	.END