function [ weak_classifiers, alphas ] = train(obj,data,labels, num_iters)
%   train the Adaboost model
% INPUT
%   data: NXD data matrix (N samples of D dimensions)
%   labels: Nx1 binary class labels (0 or 1)
%   num_iters: determines number of weak classifiers to train
%OUTPUT
%   weak_classifiers: a cell array of function handles returning a binary
%                     class label
%   alphas: sum-to-one weights for each of the weak-classifiers

classifier = obj.classifier;

%stability parameter
eps_sta = .01;

[N, ~] = size(data);
weights = ones(N,1) ./ N;
alphas = zeros(num_iters, 1);
weak_classifiers = {1:num_iters};
for m = 1:num_iters
    
    [y_m, J] = classifier(data, weights, labels, m);
    eps_m = J / sum(weights);
    alphas(m) = log((1-eps_m + eps_sta)/(eps_m + eps_sta));
    weak_classifiers{m} = y_m;
    
    %heavily weight incorrectly classified data
    weights = weights .* exp(alphas(m) * (y_m(data)' == labels));
end

%want alphas to sum to one
alphas = alphas / sum(alphas);

%set object state
obj.trained = true;
obj.weak_classifiers = weak_classifiers;
obj.alphas = alphas;
obj.num_classifiers = num_iters;

