function [ dataTrans ] = Polynomial_Basis( data )
%  Implementation of Polynomial Basis
%   Inputs: data Matrix NXD 
%   Ouputs: NX(D+1) vector put through the basis 
%       -adds first column for our Wo
%   NOTE: could input a matrix of N data points (NxD)
%       -ouputs the Basis ('design') Matrix

[rows, cols] = size(data);

%one more column for our Wo
dataTrans = zeros(rows,cols+1);

for i=1:rows
    
    for k=1:(cols)
        dataTrans(i,k+1) = data(i,k) ^k;
    end 
    
end 

%assign first column as 1's for our Wo
dataTrans(:,1) = ones(rows,1);

end

