.ORIG x3000
;Output introduction string
;
LEA 	R0, WORDS			;load address to string
PUTS					;output string (TRAP x22)
ADD	R1, R1, #10			;R1 holds Number. Too lazy to figure out inputs today, using 10.
ADD	R2, R2, #5;;;;;;;;;;;;;;;;;;;;;;;R2 is meant to hold "TestNumber" which is R1's Number/2. I do not have the division code, so like R1 I'm doing it manually here.
ADD	R3, R3, #0			;R3 holds SquareTestNumber. This is where R2^2 is stored for comparison.
ADD	R4, R4, #10			;R4 holds RootCounter. Each iteration this goes down by 1, to prevent an infinite loop. Termination at R4=#0.
ADD	R5, R2, #0			;R5 holds SquareCounter. Since squaring is adding a number to itself times equal to itself, R5 is set to R2.
ADD 	R6, R6, #0			;R6 holds Ender. Used to contrast and check if we've found the square root by some miracle of science.
ADD	R7, R1, #0			;R7 holds Previous. This is used when/if the loop fails the first time to store previous numbers. Begins as Number.
					;That's the end of the very messy variables. I promise I'll clean them up later. 
;ROOT LOOP BEGINS
	ADD	R4, R4, #-1		;Counter decreased by 1, result goes back into Counter.
	BRn	x0018			;If Counter passes 0 and becomes negative, branches to the end. No infinite loops here.
		;SQUARE LOOP BEGINS
		ADD	R3, R3, R2	;R3's SquareTestNumber (0 to start) has the TestNumber added to it. This happens until Square Counter=0
		ADD	R5, R5, #-1	;Square Counter goes down by 1 after one addition has been performed.
		BRnz	x0003		;If Counter is 0 or somehow negative, branch ahead 3 lines.
		BRp	#-4		;If Counter is still positive, branch backwards 4 and repeat.
		;SQUARE LOOP ENDS
	NOT	R3, R3			;NOT the SquareTestNumber as we make it a negative number
	ADD	R3, R3, x0001		;ADD 1 to SquareTestNumber to finish 2's compliment.
	ADD	R6, R1, R3		;R6 now holds (Number-SquareTestNumber).
	BRz	#14			;If R6 is 0, that means SquareTestNumber=Number, and therefore TestNumber is Number's Square Root. Branch to the end.
	BRn	#3			;If R6 is negative, that means SquareTestNumber is too large. Branch to "Too Large" loop to retry.
	BRp	#6			;If R6 is positive, that means SquareTestNumber is too small. branch to "Too Small" loop to retry.
		;TOO LARGE LOOP BEGINS
		ADD	R7, R2, #0	;Previously now stores Number/2. If the next loop is too small, this lets it search numbers between the small result and the last result that was too high.
		;;;;;;;;;;;;;;;;;;;;;;;;;At this point, TestNumber in R2 would be halved so the loop could begin again.
		BRnzp	#-18		;Branch back to the start and try again with a smaller TestNumber.
		;TOO LARGE LOOP ENDS
		;TOO SMALL LOOP BEGINS
		ADD	R2, R2, R7	;Last number that was too large+TestNumber. If no such number has been found yet, just use the inputted Number.
		;;;;;;;;;;;;;;;;;;;;;;;;;At this point, the new TestNumber in R2 would be halved so the loop could begin again.
		BRnzp	#-23		;Branch back to the start and try again with the larger TestNumber
		;TOO SMALL LOOP ENDS
;ROOT LOOP ENDS
;
LEA 	R0, OUTRO			;load address to string
PUTS					;output string (TRAP x22)	
;	
HALT
WORDS .STRINGZ "Dayson's Square Root skeleton!"
OUTRO .STRINGZ "The square root has been found!"
.END

