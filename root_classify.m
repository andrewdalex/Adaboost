function [ class ] = root_classify( testPoint, root )
%{
    Function to classify a new test point based on a tree with given root 

    Inputs: 
        1. X - Nx4 matrix of new points 
        2. root - root of the tree 

     Outputs: 
        1. class - Nx1 vector of class labels 

    See Readme for full design 

%}

classified = 0;
[rows, ~] = size(testPoint);
class = zeros(rows,1);

for i=1:rows
    node = root;
    while(classified ==0)
        %base case - check if at a leaf 
        if(~(isstruct(node.left) && isstruct(node.right)))
            class(i,:) = node.classification;
            classified =1;
        else 
            root.d_stump(testPoint)
            if(root.d_stump(testPoint) ==1)
                node=node.right;            
            else 
                node = node.left;
            end             
        end         
    end 
end     
        
        
end 
    
    
    
    
 