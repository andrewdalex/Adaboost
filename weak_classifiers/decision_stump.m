function [ classifier, J ] = decision_stump(data, weights, labels)
%decision_stump determines optimal decision stump and returns classifying
%function
%INPUT:
%   data: a Nx1 vector of data points
%   weights: relative weights for each data point
%   labels: binary class labels for the data (ie 0 or 1)
%OUTPUT:
%   classifier: a funtion taking a new data point, and returning a
%               predicted class label
%   J: the optimal minimum value

%determine 'right' and 'left' classes
means(1) = mean(data(labels==0));
means(2) = mean(data(labels==1));
[~, left] = min(means);
[~, right] = max(means);
left = left - 1;
right = right - 1;

%Iterate to find optimal boundary
max_iter = 10000;
min_error = Inf;
curr_boundary = min(data);
step_size = (max(data) - min(data)) / max_iter;
while curr_boundary < max(data)
    err = sum(weights(data < curr_boundary & labels==right));
    err = err + sum(weights(curr_boundary <= data & labels==left));
    if err < min_error
        opt_boundary = curr_boundary;
        min_error = err;
    end
    curr_boundary = curr_boundary + step_size;
end
a = [right, left];
classifier = @(x) a((x < opt_boundary) + 1);
J = min_error;
end
