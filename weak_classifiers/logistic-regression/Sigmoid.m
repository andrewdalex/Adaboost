function [ Sigx ] = Sigmoid( x )
%Implementation of Sigmoid function 
%
%   Inputs: x - some number 
%
%   Outputs:  1/(1+exp(-x)) evaluated at x 
%

Sigx = 1/(1+exp(-x));

end

