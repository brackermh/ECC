# Error Correcting Code Comparison Simulation

  This program is meant to be used in conjuction with a previously designed 16-bit hardware implementation of a Hamming error correcting code (ECC) circuit with additional XOR gates added after each logic gate to allow implementation of error injection into the design. The program runs through every possible input and randomly selects individual logic gates and transistors to inject errors into using MATLAB code.
The program also notes the input sent out to the circuit and the output received and compares the two generating statistics in reliability and how critical areas of the design are to output integrity. Comparisons are done by running a golden copy ECC simulation that mimics the hardware design and comparing outputs for given inputs using the ErrorPin.m and Simulation.m files. Results are then appended to an Excel file allowing observation of results.

The main purpose of this project was to generate an ECC simulation that represents the effects of single event upsets on different implementations. 

## Requirements:

**Digilent Toolbox Add-On**  
**SLU AD2/Matlab tools**

## How to use:

1. Download and all files into same directory.
   - Simulation.m contains the Hamming Code encoder/decoder simulation used for result comparisons with the hardware simulation.
   - ErrorPin.m simulates the number of transistors implemented into a specific logic gate. This is referenced to the Hamming Simulation to calculate the odds of a bit flip if a specific transistor is affected by radiation effects.
   - Main.m set's up the Analog Discovery 2 devices then begins injecting errors into individual simulated logic gates. It records the Signal sent, Numbered logic gate affected, transistor affected, the received output after ECC decoding, and various parameters for observing Analog Discovery 2 status. 
2. Open Main.m and adjust parameters as needed.
   - The default state of the simulation is to run through each of the possible 16-bit combinations 1000 times ensuring a total of 16000 total runs for comparison. The number of runs per bit can be changed by adjusting the first line of the Error Injection for loop (for CLK = 1:1000).
   - Outputs of the simulation are saved in an Excel file in the same folder named ArrayHam.csv
3. Connect I/O pins of the Analog Discovery 2 to respective error XOR gates in circuit design.
4. Run main.m, it will cycle through the specified number of runs and output results to a .csv file


