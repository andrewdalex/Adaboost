function b_train(obj,data,labels, num_iters, class_num)
%   train the Adaboost model on binary labelled data
% INPUT
%   data: NXD data matrix (N samples of D dimensions)
%   labels: Nx1 binary class labels (0 or 1)
%   num_iters: determines number of weak classifiers to train
% OUTPUT
%   weak_classifiers: a cell array of function handles returning a binary
%                     class label
%   alphas: sum-to-one weights for each of the weak-classifiers

classifier = obj.classifier;

%stability parameter
eps_sta = .01;

[N, ~] = size(data);
weights = ones(N,1) ./ N;
for m = 1:num_iters
    
    [y_m, J] = classifier(data, weights, labels, m);
    eps_m = J / sum(weights);
    obj.alphas(class_num, m) = log((1-eps_m + eps_sta)/(eps_m + eps_sta));
    obj.weak_classifiers{class_num, m} = y_m;
    
    %heavily weight incorrectly classified data
    weights = weights .* exp(obj.alphas(class_num, m) * (y_m(data) ~= labels));
end

%want alphas to sum to one
obj.alphas(class_num, :) = obj.alphas(class_num, :) / sum(obj.alphas(class_num, :));

end
