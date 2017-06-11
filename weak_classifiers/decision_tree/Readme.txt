
	Patrick La Fontaine		Math 156
							6/7/2017
	plafontaine@ucla.edu	Final Project 
	
	
					ADABOOST WITH WEAK LEARNERS 
						DECISION TREES OF SMALL DEPTH 

PROBLEM

Design a decision tree as a weak learner to correctly plug into the Adaboost classification algorithm 
		

ANALYSIS

inputs:	1. UCI DataSet 
			-3 classes of Flowers, 4 attributes to each element 
				-Petal width/length; Sepal width/length 
				
		
		
outputs:	1. Weak Learner Decision Tree to an anonymous function 

				
formulas:	1. E(S, C) = -P+ log2 (P+) – P- log2(P-)
				-Entropy of set S relative to class C
				-P+ = Relative number of elements in Class compared to size of class 
				-P- = "							not in our class compared to size of class"
					-ea if C=1;  P+ elements in C1, P- = elements !in C1 
					
			2. Gain(data, weights, labels) = E(labels) - SUM([|Sv|/|S|] * E(labelsSv))
			
constraints:	N/A
				

DESIGN

	A. Entropy E(Labels)
		1. Inputs 
			a. Set of Positive and Negative Elements 	***Don't need this if have Labels 
				-Input as Nx1 vector 
			b. L = label for classes 
				-calculated wrt S prior to calling this function (calculated in Adaboost)
		2. Outputs
			a. Entropy - scalar value 
				-=0 if all same class 
				-=1 if 50-50 split 
				
		3. Design 
			a. return Formula (1) evaluated accordingly 
				-P+ = number of ones in Labels 
				-P- = number of 0's in Labels 
			
	B. Decision Stump 
		1. Inputs
			a. Data 
				Nx1 vector of data points 
				-only their value for a given Attribute? 
					Ie if testing 1st attr then only first column?
			b. Weights 
				-relative weights for each data point 
			c. Labels 
				-Nx1 vector with binary class labels  
					-ie testing class 1, elt in Labels corresp. to data point of clas 1 =1, else =0
					
		2. Outputs 
			a. classifier 
				-the decision stump function classifier, takes in a data point x 
				
			b. J 
				-min error of this decision boundary 

	C. Gain(data, weights, labels, attr) 
		1. Inputs: 
			a. Dataset data 
				-Nx1
			b. weights 
				-necessary for Decision_stump
			c. Labels 
				-Nx1 binary vector labeling the data for given class Ci in the overall Algorithm
			d. attr
				-the attribute (column of the data) we want to test 
			
		2. Outputs 
			a. Gain 
				-the amount of entropy reduced in the set by testing that attribute 
**			b. Sv1 
				-the data set of first split 
				-the data variable for recursive calling on this splitted set 
			c. LabelsSv1 
				-corresponding labels of first split 
				-the Labels variable for recursive calling 
			d. Sv2 
			e. LabelsSv2 			
**			f. d_stump 
				-the decision stump found in the function 
				-saved in the struct 
		3. Design 
			a. get the Rows of S to iterate Through 
				-also number to divide for |S|
			b. Separate Svi
				
				i. Sv1 = elements of attribute 1 in the data 
				ii. Sv2 = elements of attribute 2 in the data 
					-these 2 vectors calculated by decision_stump
					
					
				iii. LabelsSv1 = corresponding labels after the split of data assigned to Sv1 
				iv. LabelsSv2 = corresponding labels after split of data assigned to Sv2 
				
				v. Design 
					-call [classifier, ~] =decision_stump(data, weights, labels)
						-classifier becomes our function to pass into 
					-loop thorugh data 
						-call classifier on each point 
							-if classifier =1, put into Sv1 and the corresponding label into LabelsSv1 
							-else put into Sv2, LabelsSv2 
					
			c. Entropy(Svi)
				i. = size(Svi)/size(S) * Entropy(LabelsSvi) 
			
			d. Gain 
				-evaluate Formula(2) accordingly
			
	D. ID3(data, weights, labels, attributes)
		1. Inputs 
			a. data 
				-set of all data points 
				-or, in subsequent recursive calls, a subset depending on the split in previous iteration 
			b. weights 
				-given weights used in decision_stump function 
				-calculated in Adaboost? 	
			c. labels 
				-binary labelling of data corresponding to certain class 
			d. attributes 
				-vector containing the Attributes we can test 
				-Initially, attributes = [1,2,3,4] corresponding to the 4 columns of info we have for each 
					data point 
				-each subsequent iteration removes the attribute tested at that stage 
					-ea test attribute 2 in iteration 1, next iteration attribute=[1,3,4]
					
		2. Outputs 
			[root]
			
			
			a. root 
				-The root of our trained tree 
		
		3. Design 
			1. Create root Node: node 
			2. Assess Base Cases 
				
				if(dataLabels == 1's) 
					node.d_stump = null 
					node.left = null 
					node.right = null 
					classifier = 1 
				else if(labels ==0's)
					same thing, classifier =0
				else if(Attributes = empty set) 
					nulls 
					-classification being the max(1's, 0's in Labels)
					
			3. Recursive Step 
				if none of the base cases then begin 
				a. find Attribute to use	
					-loop through list of attribute and test gain function 
					-save the gain function with max gain 
						-also corresponding returners: Sv1, LabelsSv1,....classifier 
						
				b. if(Sv1 empty) 
					-node.left = nulls, classification = max of {1,0} in Labels 
				c. else 
					-nodeleft = Id3(.....)
				d. if(Sv2 empty) 
					-node.right = nulls classification = max...
					else 
						node.right = Id3(Sv2.....)
						
				** Deal with attributes = empty set after stump => max{1's,0's in data}
				
					
					
					
	E. node_Struct 
		1. Inputs: none 
		2. Outputs: none (ish)
		
		3. Fields 
			**** No null value in Matlab, so if leaf then assign a-c to 0 (sentinel value)
			a. d_stump(x)
				-function handle for the classifier of the decision_stump of this node found in the Gain function 
			b. left
				-structure to the left of this node 
				-if(d_stump(x) ==1) => send the data to this struct 
			c. right 
				-structure to the right of this node 
				-if(d_stump(x)==0) =>send data to this struct 
				
			d. attribute 
				-the attribute (column) of the data we're testing
			e. class 
				-classification if this node is a leaf 
				
	E. Decision Tree(x)
		1. Inputs
			-x - the new test point
		2. Outputs 
			-binary classification 
			
		3. Nodes 
			-31x1 vector of nodes 
				-note 31 is max number of nodes (including leaves) that a tree could have 
		
		
		4. Design 
			-classified = false;
			-classification = 20;
			-node = root =Nodes(1)
			While(!classified)
				-pass data into node.d_stump 
				-this returns {1,0}
				-if(return) ==1
					-node = node.left 
				else if return ==0 
					-node = node.right 
				else (if leaf)
					classification = node.class 
					classified = true 
					
					3. Design 
			set classified = false 
			classification = 20   -garbage value for debugging purposes 
			node = root = Decision Tree.Nodes(1)
			while(!classified) 
				-pass data into node.d_stump 
				if(node.right ==null && node.left == null) 
					-=> we are at a leaf 
					-if(dataLabels = 1's) 
						classification = 1 
					else if(dataLabels == 0's)
						classification =0 
					else 
						find number of 1's and 0's in set 
						classification = max 
						
				if(^==1)
					node = node.left 
					node.left = ID3(Sv1....
					node.right = Id3(Sv2....
				else if (==0)
					node = node.right 
					node.left = ID3(Sv1....)
					node.right ID3(Sv2...)
				else 
					classified = true 
					assign d_stump to classifier returned in ID3 
					
	F. root_Classify 
		1. Inputs 
			a. X 
				-the new test points 
			b. root 
				-the root of tree constructed 
				
		2. Outputs 
			a. binary classification {1,0}
			
		3. Design 
			-classified = false 
			while(!classified)
				-check if at a leaf:base case 
					-ie: node.right = 0 && node.left = 0 (sentinel value)
					-if so, return classification 
					classified =true 
				else: recursive case 
					-check the attribute that the given node tests 
					if(node.d_stump(x(node.attribute) >0 
						node= node.right 
					else 
						node=node.left 
	
	G. d_tree
		1. Inputs 
			a. data 
			b. weights 
			c. labels 
			
		2. outputs 
			a. classifier 
				-returns root_classify within an anonymous function 
				
		3. Design 
			1. obtain our tree 
				-call root = ID3(inputs) 
				
			2. classifier = @(x) root_classify(x,root)
				-our weak learner 
							
SIDE NOTES 
	-Denali- call this (a multiple of) 3 times 
		class 1 vs !class 1 
		class 2 vs !class 2
		class 3 vs !class 3 
			-Possible problems: what if class not identified as 1,2,3? 
				-hopefully running algorithm again with new weights on these data fixes it 
	
TESTING


IMPLEMENTATION
	-See Adaboost Weak Learners Folder 
*/


ERRORS -
		-1-3 solved 
	 Called adaboost.train, gets an error on decision stump 
		1. Opt_Boundary 
			-not being set 
			-data =   [6;6]
			-labels = [1;0]
			-weights = [.0125;.0318]
			
			
				
		2. Adaboost- classify 
			-for Decision_Tree, need the w{i,j}(data) to be transposed 
				-andy can't have it transposed 
				-sort it later 
				
		3. Decision_Tree error in classification for adaboost 
		
		
		4. Running adaboost with 4 learners 
			-does it 8+ times? output done at end of decision tree algorithm and output 8 times 
				then program stopped as if in infinite loop 
					-when paused, went to decision_stump err = err + sum( ...)