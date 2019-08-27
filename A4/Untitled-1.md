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

    1. Start/Pause/Halt LEDs
        1. Enter 9000 as that is the start address of where the instructions are stored.
        2. Press GO.
        3. After this to start LEDs switch on the dip6 on LCI.
        4. To pause LEDs switch on the dip8 on LCI.
        5. To Halt the process, switch on the dip2.

    2. Elevator Simulation
        1. Firstly load the location of the boss floor in the memory location 8200H. Any request from BOSS is given top priority and lift proceeds to go towards BOSS to service him at the earliest. Lift takes him/her to Ground floor and then services remaining.
        2. Enter 9000 as that is the start address of where the instructions are stored. Press GO.
        3. Using the dip switches on LCI different requests can be made for the elevator.