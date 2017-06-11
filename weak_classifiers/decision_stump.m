function [ classifier, J ] = decision_stump(data, weights, labels, i_num)
%decision_stump determines optimal decision stump and returns classifying
%function
%INPUT:
%   data: a NxD matrix of data points (N samples of D dimension)
%   weights: Nx1 relative weights for each data point
%   labels: Nx1 binary class labels for the data (ie 0 or 1)
%OUTPUT:
%   classifier: a funtion taking a new data point, and returning a
%               predicted class label
%   J: the optimal minimum value
[N, D] = size(data);
if N ~= length(labels)
    error('Size mismatch between labels and data');
end
if N ~= length(weights)
    error('Size mismatch between weights and data');
end

col_id = mod(i_num-1, D) + 1;
curr_attr = data(:, col_id);

%determine 'right' and 'left' classes
means(1) = mean(curr_attr(labels==0));
means(2) = mean(curr_attr(labels==1));
[~, left] = min(means);
[~, right] = max(means);
left = left - 1;
right = right - 1;

%Iterate to find optimal boundary
max_iter = 10000;
min_error = Inf;
curr_boundary = min(curr_attr);
step_size = (max(curr_attr) - min(curr_attr)) / max_iter;
while curr_boundary < max(curr_attr)
    err = sum(weights(curr_attr < curr_boundary & labels==right));
    err = err + sum(weights(curr_boundary <= curr_attr & labels==left));
    if err < min_error
        opt_boundary = curr_boundary;
        min_error = err;
    end
    curr_boundary = curr_boundary + step_size;
end
a = [right, left];

%classifier takes entire data but extracts appropriate attribute
classifier = @(x) a((x(:, col_id) < opt_boundary) + 1)';
J = min_error;
end
