function [ Err ] = Gradient_Error( design_matrix, labels, W, weights)
%{
    Implementation of Error of our Gradient function 

    1. Inputs 
			a. design_matrix 
				-for calculating the yn
                -N x (D+1) 
                    e/ row = [PHI0(Xn), PHI1(Xn),...PHI4(Xn)]
				
			b. labels 
				-class labels: tn 
				
			c. W 
				-needed for calculating Yn each iteration 
                -(D+1)x1

            d. weights 
                -of each point from the Adaboost. Multiply each point by
                its weight in the calculation of error 
				
		2. Ouputs 
			-the gradient of the error function at a given set of coefficients W 
				- (D+1)x1 vector 
				
		3. Design 
			implements formula:
            dE(W) = sum(1:n) (yn-tn)PHI(n) 
				-PHI(n) = PHI(Xn)
				-yn = sigmoid(w'*PHI(n)
				-tn = classificaiton in training data 
%}

[rows, ~] = size(design_matrix);
Y=zeros(rows,1);



%Calculating predicted Y
for i=1:rows
   % design_matrix(i,:)
   % W
  % design_matrix(i,:);
   %W
    Y(i) = Sigmoid(design_matrix(i,:) * W);
    
end 

misclassified = Y - labels;
weightedMisclassified = misclassified .* weights;

[wrows,~] = size(W);
Err = zeros(wrows, 1);

for i=1:rows
    
    Err = Err + (weightedMisclassified(i) * design_matrix(i,:))';    
end 




end

