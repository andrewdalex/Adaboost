function [ scalar ] = Gaussian_Basis( data )
% Attemp to implement Gaussian Basis function 
% PHIk(data) = exp(-norm(data - mean(data))^2 / (2*var(data)^2)

varData = var(data);
meanData = mean(data);


[rows,~] = size(data);
scalar = zeros(rows,1);

for i=1:rows
    scalar(i,:) = exp(-(1.5*(norm(data(i,:) - meanData)^2)));
    
end 

end

