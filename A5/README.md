
Steps to complete Assignment 5.
There are 6 diff asm codes. The driver program and 5 waveforms. We will load each one individually at different locations and finally execute the overall program.

NOTE:: All these files are also kept in Downloads\esa-xt85 folder. We can compile and upload the code from there only. Also We don't need to input lst file as parameter for c16 command.

1. c16 -h out.hex driver.asm
2. ctrl+D :out // the driver (main) program is loaded at location 8400h
3. c16 -h out.hex Tr.asm
4. ctrl+D :out // the code for Triangular wave is loaded at location 9000h
5. c16 -h out.hex Sq.asm
6. ctrl+D :out // the code for Square wave is loaded at location 9100h
7. c16 -h out.hex ST.asm
8. ctrl+D :out // the code for Triangular wave is loaded at location 9200h
9. c16 -h out.hex Strcse.asm
10. ctrl+D :out // the code for Staircase wave is loaded at location 9300h
11. c16 -h out.hex Symstrcse.asm
12. ctrl+D :out // the code for Symmetric staircase wave is loaded at location 9400h

Running the Program:
RUN:
    SET DIP SWITCH - GO - 8400 - EXEC - [1,2,3,4,5] - Measure - RESET
REPEAT RUN

NOTE:: The above parameter 1,2,3,4,5 are used for 5 hardcoded delays corresponding to 5 frequencies respectively, as you can see in all 5 asm files. The reason for not calculating the delays by formula is because the time consumed in calculations is signicant w.r.t. the delay we are putting.

TODO:: Calibrate all delay values to match standard frequencies like 5hz, 10hz, 15hz, 20hz, 25hz in every type of waveform


Applications:
1. Square: used to control the timing of operations such as clock generators for microprocessors.
2. Triangular: useful in many "sweep" circuits and test equipment. For example, switched-mode power supplies and induction motor-control circuits often use a triangular wave oscillator as part of the pulse width modulator (PWM) circuit.
3. Sawtooth: used to create sounds with subtractive analog and virtual analog music synthesizers.
4. Staircase: used as a storage counter.