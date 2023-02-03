1. Run the .m named "Run_this for execution of the code.

2. User interface will help you execute the code. 

3. All input files must be in .xlsx format.

4. The format of training file should be: 
Rows: features
Columns: data samples

5. The format of target data file should be binary. e.g. in this case we have 6 classes. So,

Class| C1|C2|C3|C4|C5|C6
1    | 1 |0 |0 |0 |0 |0
2    | 0 |1 |0 |0 |0 |0
3    | 0 |0 |1 |0 |0 |0
4    | 0 |0 |0 |1 |0 |0
5    | 0 |0 |0 |0 |1 |0
6    | 0 |0 |0 |0 |0 |1

6. For Acitivity Classification: The original code was run with 260 inputs and 6 classes.
7. For Gait Event Classification: The original code was run with 260 inputs and 4 classes.

8. Enter path where your code and data files are placed.

9. First section of the code trains 10 networks of different sizes. It progressively changes the number of hidden layers
in converging manner. e.g. In iteration#1, size of the network is 1 input layer, 1 hidden layer, 1 output layer;
in iteration#2, size of the network is 1 input layer, 2 hidden layers, 1 output layer; and so on, till 10 hidden layers.
The number of neurons vary in a converging manner, i.e. Hidden layer 1: 100 neurons; Hidden layer 2: 90 neurons,... Hidden layer 10: 10 neurons.

10. Second section of the code gives liberty to users for selecting their own network configuration for training. It asks for the input of from
to select their desired number of hidden layers (between 4 to 6) and the desired number of neurons.

11. The algorithm suggests the range of best configurations for whichever data is being trained, in the first section. The second section can be used
to get the final best configuration by tweeking the number of hidden layers and neurons, based on the suggestive results of phase 1 of the algorithm.



*Note: "Gait event recognition" is refered as "phase recognition" in this code.






