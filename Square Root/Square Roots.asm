;This is the squareroot with factoring
;Created by Dayson and Caiden
;Inputs R3 = Inside
;output R3 = Outside, R4 = Inside
;Division inputs: Divided at R3 and Divisor at R2 and outputs the total to R2 and the Remainder to R3. Uses R5, R6, and R7.
;!!!I am modifying the Division code to output the total to R4 and the remainder to R1

.ORIG x3200
	LD 	R1 	Remainder;/Outside/Test	;R1 holds the number outside the square root, as well as the remainder of division
	LD 	R2	Divisor			;R2 is where the divisor for division goes
	LD 	R3	Divided			;R3 holds the input number from the Main code, and the divided for the division code
						;!!!Will need to be converted to ST when plugged into the Main code!!!
	LD 	R4	Total			;R4 holds the results of division
START	LD	R7	DIVJUMP			;Load the address of the division code	
	JSRR	R7				;R3/R2 R4=total and R1=Remainder
	ADD	R1 R1	#0			;Set the flags onto the Remainder
	BRz		PATH			;If the Remainder is 0, jump to PATH. If not, prepare to repeat the loop.
CYCLE	ADD	R2 R2	#1			;Increase the Divisor by 1.
	NOT	R1	R2			;Two's Complimenting Divisor into R1 (1/2)
	ADD	R1 R1	#1			;Two's Complimenting Divisor into R1 (2/2)
	ADD	R1 R1	R3			;Subtract R3(Input)-R1(Divisor)
	BRnz		SAME			;If R3(Input)-R1(Divisor) = 0 it means we have a Prime Number. Branch to SAME.
	BRp		START			;But most of the time this test isn't needed, and we can just begin the loop again.
PATH	STI	R3	Input			;Going to have to save the original input in memory for a moment here.
	LD	R7	DIVJUMP
	ADD	R3 R4	#0			;R3 will temporarily be holding the results of R3/R2 being held in R4.
	JSRR	R7				;R3/R2/R2 R4=total and R1=Remainder.
	LDI	R3	Input			;Put the original Input back into R3.
	ADD	R1 R1	#0			;Set the flags onto the Remainder again.
	BRnp		CYCLE			;Check the remainder from R3/R2/R2. If it's not zero (probably positive), go back to CYCLE.
	LD	R7	SQRJUMP			;R7 now points to the Square code.
	ADD	R1 R2	#0			;R1 now contains a backup of the Divisor, so we can safely square R2.
	JSRR	R7				;R2=R2^2
	LD	R7	DIVJUMP			;And now it's time for division again. Load the division address into R7!
	JSRR	R7				;R3=R3(Input)/R2(Divisor^2)
	ADD	R2 R1 	#0			;Putting the divisor back into R2.
	NOT	R1	R1			;Taking the copy of the divisor and Two's Complimenting it (1/2)
	ADD	R1 R1	#1			;Taking the copy of the divisor and Two's Complimenting it (2/2)
	ADD	R1 R3	R1			;R1=R3(Input)-R1(Divisor)
	BRp		DONE			;If the result of R3-R1 is positive, we're done and we can all go home now.
	BRz		SAME			;If the result of R3-R1 is zero, I'm pretty sure something is wrong. Whatever.
TEST	ADD	R3 R3	#-1			;If the result is coming up negative, try Input-1.
	BRz		DONE			;If Input-1=0, then the Input was 1 and that was the problem. Jump to the end with R3=0
	BR		ERROR			;Otherwise throw an error because things just went wrong.
SAME	ADD	R4 R3	#0			;If the PC is here, then a Prime number was put in. Set the Inside to the Input.
	ADD	R3 R3	#1			;Also set the Outside to 1, if it's not there already.
	BRnzp		DONE		;Branch to the end, we're all done.
ERROR	LEA	R7	OOPS
PUTS

DONE					;We're done now. No matter the results, the Outside of the Root is in R3, and the Inside is in R4.
					;The DONE space is left here in case somebody knows how to use inter-code variables.

HALT
DIVJUMP   .FILL	x3000				;Address to jump to the division code.
SQRJUMP	  .FILL	x2000				;Address to jump to the squaring code.
Remainder .FILL	#1				;Remainder isn't needed often. This is the dumping ground for things. Start it at 1.
Divisor	  .FILL	#2				;This one's gonna change a lot, but it begins its life as a 2.
Divided   .FILL #12				;!!!Input is set to 12 right now.!!!
Input     .FILL	x1500				;Input will need to be saved at one point. This will be how it gets back.
Total	  .FILL #0				;Final results of division go here, not necessary to preload really.
OOPS   .STRINGZ	"An error has occurred!"	;Error message for if things just don't work.
.END

