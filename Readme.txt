
	Patrick La Fontaine		Math 156
							6/7/2017
	plafontaine@ucla.edu	Final Project 
	
	
					ADABOOST WITH WEAK LEARNERS 
						Logistic Regression 

PROBLEM

Design a Logistic Regression as a weak learner to classify data 		

ANALYSIS

inputs:	1. UCI DataSet 
			-3 classes of Flowers, 4 attributes to each element 
				-Petal width/length; Sepal width/length 
				
		
		
outputs:	1. Weak Learner set of Parameters to an anonymous function 

				
formulas:	1. Polynomial Basis PHI(x) 
				-PHI(X) = (1, X1^1, X2^2, X3^3, X4^4)
				
			2. Gradient_Error(W) = sum(1:n) (yn-tn)PHI(n) 
				-PHI(n) = PHI(Xn)
				-yn = sigmoid(w'*PHI(n))
				-tn = classificaiton in training data 
				
			3. sigmoid = 1/(1+exp(-w'PHI(n)))
			
constraints:	N/A
				

DESIGN

	A. Polynomial_Basis 
		1. Inputs: Data 
			-either a 1xD vector of single data point 
				-or a NxD matrix of data points 
				
		2. Ouputs: 
			a. data passed through the transformation basis 
				-returns either a vector or matrix depending on input 
				
		3. Design 
			-implements formula (1)
			
	B. Gradient_Error 
		1. Inputs 
			a. data 
				-for calculating the design matrix 
					used for calculating updated Yn in each iteration 
				
			b. labels 
				-class labels: tn 
				
			c. W 
				-needed for calculating Yn each iteration 
				
		2. Ouputs 
			-the gradient of the error function at a given set of coefficients W 
				- (D+1)x1 vector 
				
		3. Design 
			implements formula (2)
			
	C. Sigmoid 
		1. Inputs 
			a. x 
				-in our case this will be: W'PHI(n) 
				
		2. outputs 
			-sigmoid function evaluated at x 
			
		3. Design 
			-implements formula (3)
			
	D. Calculate Weights 
		1. Inputs 
			a. W0 
				-initial weights 
				
			b. data 
				-used in each iteration of evaluating Gradient_Error
				
			c. labels 
				
		2. Outputs 
			a. W 
				-the final weights 
			
		3. Design 
			-implements a fixed step gradient descent algorithm 
			
			a. W(K+1) = W(K) - alpha ( Gradient_Error(W(K)))
				-K = iteration number 
				-alpha = fixed step size 
				
			b. for i=1:Max_Iters 
				-run the above update 
				
				return W 
				
	E. Classify 
		1. Inputs 
			a. test 
				-Nx4 vector of data points 
				
			b. W 
				-set of weights calculated in Logistic Regression earlier 
					in adaboost algorithm 
					
		2. Outputs 
			a. Nx1 classification vector taking binary values 
			
		3. Design 
			-put data points through Basis Function (In our case Polynomial_Basis)
			-call Sigmoid(-transformedData * W) on e/ data point 
			-return vector 
			
	F. Logistic_Regression 
		1. Inputs 
			a. data 
			b. weights
			c. labels 
			d. i_num 
				-not relevant for Logistic_Regression but necessary for adaboost alg 
				
		2. Outputs 
			a. Classifier 
				-function handle 
				-calls Classify with our found W 
				
		3. Design 
			-Call Calculate_Weights on the training data 
			-return the Function handle 
	
							
SIDE NOTES 
	-Data Xi = [1, X1, X2, X3, X4] 
		- first element is for our W1 
	
TESTING


IMPLEMENTATION
	-See Adaboost Weak Learners Folder 
*/


ERRORS 