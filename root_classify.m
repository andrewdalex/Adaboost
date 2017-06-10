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

[rows, ~] = size(testPoint);
class = zeros(rows,1);
%rows
for i=1:rows
    node = root;
    classified = 0;
    while(classified ==0)
        %base case - check if at a leaf 
        if((~(isstruct(node.left) && isstruct(node.right)))&& node.classification ~=10)
           % node.classification
            class(i) = node.classification;
            classified =1;
            
        else 
          %  node.attribute
          % testPoint(i,node.attribute)
           %node.classification
          % node.d_stump
          % node.d_stump(3)
           %node.d_stump(testPoint(i,node.attribute))
         
            if(node.d_stump(testPoint(i,node.attribute)) ==0)
                node=node.right;            
            else 
                node = node.left;
            end             
        end         
    end 
end     
        

        
end 
    
    
    
    
 