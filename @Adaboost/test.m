function [ error_pct  ] = test(obj, test_data, test_labels)
%test Evaluate the accuracy of the trained model
%INPUT
%   test_data: NxD data for testing (N samples, D dimensions)
%   test_labels: Nx1 binary labels to compare predictions with
%OUTPUT
%   error_pct: percentage of test_data points misclassified

if obj.trained == false
    error('Error: Model not trained!');
end
[N,~] = size(test_data);
if length(test_labels) ~= N
    error('Size of test_labels does not match test_data');
end

preds = obj.classify(test_data);


error_pct = (sum(preds ~= test_labels) / N) * 100;


end

