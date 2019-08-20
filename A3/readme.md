Steps to Run - 
1. Open command prompt as administrator.
2. Change directory to the folder containing asm file.
3. run command "c16 -h test.hex -l test.lst file_name.asm".
4. Run xt85.exe.
5. Keep dip switch 1 on always.
6. Switch on 4th dip switch and press reset on board.
7. Press ctrl+d and enter file name test.hex
8. Press enter till download is complete.
9. Enter the input as mentioned below-

    i. First we will need to set the interrupt routine for the program, so that will be done by adding the address of "INTERRUPT" to 8fbf location.
	ii. To do this we will open the test.lst file and see from where the code starts for INTERRUPT, enter that particular address and opcode data in the field in the order OPCODE, INSTr(lower), INSTR(higher) ie C3 8E 90.
	iii. First Press the Go button.
	iv. Enter 9000 as that is the start address of where the instructions are stored.
	v. Press GO on the address display CLOC will be written. after that press any key 2 times.
	vi. Now you will see 4 0's 0000 now enter the time your want to start the clock from in the format HH:MM.
	vii. After that press the next button, so now the timer will start running from HH:MM:59.
    viii. To pause the timer, press the KBINT button.
    ix. To resume the timer, press NEXT button 2 times.
