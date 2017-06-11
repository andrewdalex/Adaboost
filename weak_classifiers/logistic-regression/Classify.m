function [ Classification ] = Classify( test, W )
%{
    Implementation of Classify function for Logistic Regression 

    Inputs: 
        1. test 
            -Nx4 collection of test data points 

        2. W 
            -previously calculated weights for our logistic regression 

    Outputs 
        1. Classification 
            -Nx1 binary vector 
%}

transformedData = Polynomial_Basis(test);
[rows,~] = size(test);
Classification = zeros(rows,1);

for i=1:rows
    Classification(i) = Sigmoid(transformedData(i,:) * W);
    %Some sigmoid function evaluations return in range [0,~.01] so doing
    %this for consistency in return values 
    if(Classification(i) < .5)
        Classification(i)=0;
    end 
end 

end

