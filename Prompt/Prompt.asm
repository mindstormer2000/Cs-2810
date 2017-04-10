
	; Here's the solution for getting double digit results. I don't know how to get inputs of more than one digit however
	; I also don't quite know what to input into the other functions and where they go
	; Hopefully these instructions are a little help

	.ORIG	x3000

	; These instructions are the promting part of the program where the user enter the values
	; For now, they're just single digit values

	LEA	R0, PRMT1	; "Enter the value for point A from 0 to 256: "
	PUTS
	GETC			; get first number
	; check to make sure it's a number
	; check to see if it's a newline
	; if it is a number
	OUT			; print entered character in R0
	; increment for character count
	; check to see if it's three
	ADD	R1, R0, 0	; put the first number in R1

	LEA	R0, PRMT2	; "Enter the value for point B from 0 to 256: "
	PUTS
	GETC			; get second number
	OUt			; print entered character in R0
	ADD	R2, R0, 0	; put the second number in R2

	LEA	R0, RSLT	; "The distance between the two points is "

	; FOR INPUT
	;
	; TENS
	; if the input is 10-19
	;	load 10 if first digit is 1, add last digit of input to 10	->	TENS	.FILL 	10
	; if the input is 20-29
	;	load 20 if first digit is 2, add last digit of input to 20	->	TWEN	.FILL 	20
	; if the input is 30-39
	;	load 30 if first digit is 3, add last digit of input to 30	->	THIR	.FILL 	30
	; if the input is 40-49
	;	load 40 if first digit is 4, add last digit of input to 40	->	FOUR	.FILL	40
	; if the input is 50-59
	;	load 50 if first digit is 5, add last digit of input to 50	->	FIFT	.FILL	50
	; if the input is 60-69
	;	load 60 if first digit is 6, add last digit of input to 60	->	SIXT	.FILL	60
	; if the input is 70-79
	;	load 70 if first digit is 7, add last digit of input to 70	->	SEVE	.FILL	70
	; if the input is 80-89
	;	load 80 if first digit is 8, add last digit of input to 80	->	EIGH	.FILL	80
	; if the input is 90-99
	;	load 90 if first digit is 9, add last digit of input to 90	->	NINE	.FILL	90
	;
	; HUNDREADS
	; if the input is 100-199
	;	load 100 if the fisrt digit is 1, add 10-19 if the second digit is 1-9, and then add the last digit	->	ONEH	.FILL	100
	; if the input is 200-256
	;	load 200 if the fisrt digit is 2, add 10-19 if the second digit is 1-9, and then add the last digit	->	TWOH	.FILL	200
	;
	; FOR OUTPUT
	;
	; TENS
	; if the result is >= 10...90 and < 20...100, subtract it by 10...90, place a 1...9 in front, and output the 1...9 and the result
	;
	; HUNDREADS
	; if it's >= 100 or 200 and < 200 or 257, subtract by 100 or 200, jump the result to one of the TENS functions, and output a 1 or 2 in front

	; use function for distance calculator		TEST WITH ADDING: ADD R0, R2, R1

	; These instructions are the tricky part, this is how the result can print more than two digits.
	; I tested this by adding two numbers and it worked, but that's all I have so far

	LD	R3, nONE	; load -48 into R3
	ADD	R0, R0, R3	; subtract 48 to get ASCII value, put it in R0

	LD	R4, nNINE	; load -57 into R4
	ADD	R1, R0, R4	; subtract 57 to get ASCII value, put it in R1

	BRnz	DONE		; if the answer is a single digit, print
	ADD	R2, R0, 0	; else, store the digits in R2

	LD	R0, pONE	; get 1, put it in front of R2
	OUT

	ADD	R0, R2, -10	; get the second digit by subtracting the number by 10, with 1 placed in front
DONE	OUT

	HALT

PRMT1	.stringz "\nEnter the value for point A from 0 to 256: "
PRMT2	.stringz "\nEnter the value for point B from 0 to 256: "
RSLT	.stringz "\nThe distance between the two points is "

nONE	.FILL	-48	; the ASCII value for -1
nNINE	.FILL	-57	; the ASCII value for -9
pONE	.FILL	49	; the ASCII value for 1

	.END