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

	The folder consist of two files-

	1. 12hrs Clock
		a. First Press the Go button
		b. Enter 9000 as that is the start address of where the instructions are stored exec.
		c. Now you will see 4 0's 0000 now enter the time your want to start the clock from in the format HH:MM
		d. After that press the exec button, so now the clock will start running.
		e. If the HH value is greater than or equal to 13 it is automatically initialised to 01.

    2. 24hrs Clock
		a. First Press the Go button
		b. Enter 9000 as that is the start address of where the instructions are stored exec.
		c. Now you will see 4 0's 0000 now enter the time your want to start the clock from in the format HH:MM
		d. After that press the exec button, so now the clock will start running.
		e. If the HH value is greater than 24 it is automatically initialised to 00.

    3. Alarm Clock
		a. First Press the Go button
		b. Enter 9000 as that is the start address of where the instructions are stored exec.
		c. Press GO on the address display CLOC will be written. after that press 0 2 times.
		d. Now you will see 4 0's 0000 now enter the time your want to set the alarm for in the format HH:MM
		e. After that press the next button, and enter the time your want to start the clock from in the format HH:MM and press exec.
		f. If the HH value is greater than 24 it is automatically initialised to 00.