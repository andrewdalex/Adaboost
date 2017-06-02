function [ error_pct] = test(obj, test_data, test_labels)
%test Evaluate the accuracy of the trained model
%INPUT
%   test_data: NxD data for testing (N samples, D dimensions)
%   test_labels: Nx1 binary labels to compare predictions with
%OUTPUT
%   error_pct: percentage of test_data points misclassified

if obj.trained == false
    error('Error: Model not trained!');
end
[N,D] = size(test_data);
if length(test_labels) ~= N
    error('Size of test_labels does not match test_data');
end

preds = zeros(1,N);
wcs = obj.weak_classifiers;
alphas = obj.alphas;
for i=1:obj.num_classifiers
    preds = preds + alphas(i) * wcs{i}(test_data(:, mod(i-1, D)+1 ));
end

error_pct = (sum((preds < .5) == test_labels') / N) * 100;


end

