function  pred_labels  = classify(obj, data)
%classify Compute predicted class labels for data
% INPUT
%   data -> NxD data (N samples, D dimensions)
% OUTPUT
%   pred_labels -> Nx1 vector of predicted class labels
if obj.trained == false
    error('Error: Model not trained!');
end
[N,~] = size(data);
score = zeros(obj.num_classes, N);
wcs = obj.weak_classifiers;
for i = 1:obj.num_classes
    for j = 1:obj.num_classifiers
        score(i,:) = score(i,:) + (obj.alphas(i,j)*wcs{i,j}(data))';
    end
end
[~, pred_labels] = max(score);
pred_labels = obj.label_map(pred_labels);
end

