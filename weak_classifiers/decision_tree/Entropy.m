function [ E ] = Entropy( Labels )
%{
    Inputs: The Labels for the Input Set 
    Outputs: The given entropy of the set 

    Calculates the entropy for a given set S relative to a class 
        -Labels- Nx1 vector of binary labels for our data 
            -calculated in Adaboost algorithm prior to input 
            -elt =1 => in P+
            -elt =0 => in P-
       -Note: doesn't take in the Set S itself as it's not needed
        
%}
[rows, ~ ] = size(Labels);
Pos = 0;
Neg = 0;
for i=1:rows
    if(Labels(i) ==1)
        Pos = Pos + 1;
    else
        Neg = Neg+1;
    end 
end 

if(Pos == rows || Neg == rows)
    E=0;
else 
    E = -(Pos/rows) * log2(Pos/rows) - (Neg/rows)* log2(Neg/rows);
end 


end

