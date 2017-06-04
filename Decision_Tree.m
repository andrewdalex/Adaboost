function [ classify, error ] = Decision_Tree( data, weights, labels, i_num )
%{
    Creates our decision tree and returns the classifying function relative
    to it 
    
    Inputs: 
        1. data 
        2. weights 
        3. labels 
        4. i_num 
            
    Outputs: 
        1. Classifier 
            -anonymous function handle pointing to our roo_classify
            function
%}
attributes=[1;2;3;4];
root = ID3(data, weights, labels,attributes);

predicted = root_classify(data, root);

error= (~(predicted==labels))' * weights;

classify = @(x) root_classify(x,root);

%d_tree = struct(f1,classify,f2,root);


end

