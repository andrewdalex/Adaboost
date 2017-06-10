function [ Classifier, Error ] = Logistic_Regression( data, weights, labels, i_num )
%{
    Implementation of Logistic Regression as a weak learner in adaboost
    algorithm 

    1. Inputs 
			a. data 
			b. weights- to be passed into calculate_weights for grad
                descent
			c. labels 
			d. i_num 
				-not relevant for Logistic_Regression but necessary for adaboost alg 
				
		2. Outputs 
			a. Classifier 
				-function handle 
				-calls Classify with our found W 
				
		3. Design 
			-Call Calculate_Weights on the training data 
			-return the Function handle pointing to our Classify function
            -see Readme for full design and functions
%}
[~, cols] = size(data);
%Wo = ones((cols+1),1);  %extra column in Wo for the Wo in logistic regres.
Wo(1:cols+1, 1) = 1;      %Testing different Wo
W = Calculate_Weights(data, labels, Wo, weights);
Predicted = Classify(data, W);
%Predicted 
%labels
%weights

%weights
Error = (~(Predicted == labels))' * weights;
%Error
%Error = sum(Error1);


Classifier = @(x) Classify(x,W);


end

