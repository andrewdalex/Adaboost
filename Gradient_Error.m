function [ Err ] = Gradient_Error( design_matrix, labels, W )
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

%W
for i=1:rows
   % design_matrix(i,:)
   % W
    Y(i) = Sigmoid(design_matrix(i,:) * W);
    
end 

Err = (Y-labels) .* design_matrix;

Err = sum(Err);



end

