function train(obj, data, labels, num_iters)
%train Trains multiclass adaboost model
%INPUT
%   data -> NxD data matrix (N samples, D dimensions)
%   labels -> Nx1 numerical labels corresponding to the data samples
%   num_iters -> number of models to train for each class
%OUTPUT
%   no explicit return, sets classifiers and associated alphas in object
%   state
obj.label_map = unique(labels);
num_classes = length(obj.label_map);

%preallocate data structures for model
obj.weak_classifiers = {num_classes, num_iters};
obj.alphas = zeros(num_classes, num_iters);

for i = 1:num_classes
    bin_labels = (labels == obj.label_map(i));
    obj.b_train(data, bin_labels, num_iters, i);
end
%set object state
obj.trained = true;
obj.num_classifiers = num_iters;
obj.num_classes = num_classes;
end

