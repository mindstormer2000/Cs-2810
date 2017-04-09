.ORIG x3000					;For Division to work, Registers 7, 6, and 5 need to be open. Division is R6/R7=TOTAL,REMDER
						;Square code also requires 7, 6, and 5 be open.
						
	LD	R0 	NUMBER			;R0 holds Number. Will later need to work with Input from framework
	LD	R1 	NUMBER			;R1 holds Previous. This is used when/if the loop fails the first time to store previous numbers. Begins as Number.
	AND	R2	R2,#0			;R2 remains open for TOTAL to go into. All dividends are stored in R2.

SQRTEST	LD	R3	NUMBER			;R3 holds SquareTestNumber. This is where NUMBER/2^2 is stored for comparison. Division is also performed on this register.
	LD	R4 	RTCOUNT			;R4 holds RootCounter. Each iteration this goes down by 1, to prevent an infinite loop. Termination at R4=#0.
	LD	R6	DIVJUMP			;R6 holds division code's address. R6 will also be used to check if SQTEST^2=NUMBER when not being used for Division
;;	ST	R0	DIVIDED			;Stores NUMBER into R2's DIVIDED for the upcoming trip to x0000's division process.
	JSRR	R6				;Hop to the Division code. Outputs TOTAL.
COLLECT	ADD	R2	R2,#0			;R2 holds TOTAL, which is NUMBER/2
	BRn	ERROR				;If NUMBER/2 is negative, NUMBER is negative. Cannot take square root of a negative.
;
						;That's the end of the very messy variables. I promise I'll clean them up later. 
	NOT	R0, R0				;NOT NUMBER as we make it a negative number.
	ADD	R0, R0, x0001			;ADD 1 to NUMBER to finish 2's compliment.
	;ROOT LOOP BEGINS
	RSTART	ADD	R4, R4, #-1		;Counter decreased by 1, result goes back into Counter. Division code lets out here.
		BRn	ENDING			;If Counter passes 0 and becomes negative, branches to the end. No infinite loops here.		
		;SQUARE BRANCH BEGINS
			LD	R6	SQRJUMP	;Loads the Square code location to R6.	Will Square the contents of R2.
		SQUARE	JSRR	R6		;Hop to the Square code. Outputs OUTPUT. 
		;SQUARE BRANCH ENDS
	;SRETURN	LD	R3	OUTPUT	;R3 now holds (NUMBER/2)^2.
		ADD	R6, R0, R3		;R6 now holds (SquareTestNumber-NUMBER).
		BRz	ENDING			;If R6 is 0, that means SquareTestNumber=Number, and therefore TestNumber is Number's Square Root. Branch to the end.
		BRn	SMALL			;If R6 is negative, that means SquareTestNumber is too small. Branch to "Too Small" loop to retry.
		BRp	LARGE			;If R6 is positive, that means SquareTestNumber is too large. branch to "Too Large" loop to retry.
			;TOO LARGE LOOP BEGINS
		LARGE	ADD	R1, R2, #0	;Previously now stores Number/2. If the next loop is too small, this lets it search numbers between the small result and the last result that was too high.
			AND	R3, R3, #0	;Now we need to find R2/2. First we clear out R3 since we don't need it right now.
			ADD	R3, R2, #0	;R3 now contains R2 and can be run through Division again.
			LD	R6	DIVJUMP	;No further need for the number in R6, reset to Division address.
			JSRR	R6		;Hop to the Division code. Outputs TOTAL to R2.	
		LRETRY	BRnzp	RSTART		;Branch back to the start and try again with a smaller TestNumber.
			;TOO LARGE LOOP ENDS
			;TOO SMALL LOOP BEGINS
		SMALL	ADD	R2, R2, R1	;Last number that was too large+TestNumber. If no such number has been found yet, just use the inputted Number.
			AND	R3, R3, #0	;Now we need to find R2/2. First we clear out R3 since we don't need it right now.
			ADD	R3, R2, #0	;R3 now contains R2 and can be run through Division again.
			LD	R6	DIVJUMP	;No further need for the number in R6, reset to Division address.
			JSRR	R6		;Hop to the Division code. Outputs TOTAL to R2.	
		SRETRY	BRnzp	RSTART		;Branch back to the start and try again with the larger TestNumber
			;TOO SMALL LOOP ENDS
	;ROOT LOOP ENDS
;
ERROR	LEA	R0	WRONG			;load error message to string
	PUTS					;output error message
	BRnzp	CLOSED					;For now this unconditionally branches to HALT. Later, need to branch back to input
ENDING	LEA 	R0	OUTRO			;load address to string
	PUTS					;output string (TRAP x22)
;	NOT	R3, R3				;NOT the square root as we make it a positive number
;	ADD	R3, R3, x0001			;ADD 1 to the square root to finish 2's compliment
	LD	R3	SQROOT			;Load the square root into SQROOT for use in the main framework
;	

CLOSED	HALT
NUMBER	.FILL	#9					;Assuming first program's result was 9. This section will need an update when the Framework is ready. Presently not compatible with remainders
;SQRTEST	.FILL	#0					;SQRTEST begins at 0, and may not be necessary to declare. edit: removed
RTCOUNT	.FILL	#10				;RootCounter is used to terminate the actual Square Root loop. May not need two counters. edit:second counter removed
DIVJUMP .FILL	x0000				;Address to jump to the division code
SQRJUMP	.FILL	x2000				;Address to jump to the squaring code
;PCJUMP	.FILL	COLLECT				;PCJUMP begins set to COLLECT. edit:not in use
;PCRTRN	.FILL	SRETURN				;PCRTRN begins set to SRETURN. edit:not in use
DIVIDED	.FILL	#0
PREV	.FILL	NUMBER				;Previous begins as NUMBER. Becomes R2 if the Too Large loop is triggered
SQROOT	.FILL	#0				;This is where the final answer goes.
TOTAL	.BLKW	0				;Sets aside memory for TOTAL from Division
OUTPUT	.BLKW	0				;Sets aside memory for OUTPUT from Square. Can save space by overwriting TOTAL
OUTRO 	.STRINGZ "The square root has been found!"
WRONG	.STRINGZ "Error: Cannot square root a negative number."
.END

