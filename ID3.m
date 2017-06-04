function [ Node] = ID3( data, weights, labels, attributes )
%{
    Implementation of the ID3 algorithm to create a decision tree of smal
    ldepth 
    
    1. Inputs 
		a. data 
			-set of all data points 
            -or, in subsequent recursive calls, a subset depending on
               the split in previous iteration 
		b. weights 
			-given weights used in decision_stump function 
		c. labels 
			-binary labelling of data corresponding to certain class 
		d. attributes 
			-vector containing the Attributes we can test 
			-Initially, attributes = [1,2,3,4] corresponding to the 4 
               columns of info we have for each 
				data point 
			-each subsequent iteration removes the attribute tested at 
               that stage 
				-ea test attribute 2 in iteration 1, next iteration
                   attribute=[1,3,4]
				
	2. Outputs 
**	[Node, Sv1, LabelsSv1, Sv2, LabelsSv2, weights1, weights2, attrUpdated]
        a. Node= the Node structure created at this decision 
        b. Sv1, LabelsSv1, weights1 
            -the data and weights corresponding to positive (left) split 
        c. Sv2, LabelsSv2, weights2 
            -data and weights corresponding to negative (right) split 
        d. attrUpdated 
            -the updated set of possible attributes to test 
            -removes the attribute tested at this node 

     See Readme documentation for full Design

%}

f1 = 'd_stump';
f2='left';
f3='right';
f4='classification';

d_stump = 0;
left =0;
right =0;
classification =10;


                
    
%Base cases: labels are either all pos or all negative    
[labelsSz, ~] = size(labels);
testOnes = ones(labelsSz, 1);
testZeros = zeros(labelsSz,1);

if (isequal(labels,testOnes))
    classification = 1;
    Node = struct(f1,d_stump,f2, left, f3, right, f4,classification);
 %%   Sv1 =[];
 %   LabelsSv1 = [];
 %   weights1=[];
 %   Sv2=[];
 %   LabelsSv2 =[];
 %   weights2 = [];
 %   attrUpdated = [];

elseif(isequal(labels,testZeros))
    classification = 0;
    Node = struct(f1,d_stump,f2, left, f3, right, f4,classification);
  %  Sv1 =[];
  %  LabelsSv1 = [];
  %  weights1=[];
  %  Sv2=[];
  %%  LabelsSv2 =[];
   % weights2 = [];
   % attrUpdated = [];    

else  
         %Calculate the max of 0's or 1's just in case Sv1 or Sv2 lead to
        %leaves 
        %Also if attributes empty create leaf
       Pos = 0;
       Neg = 0; 
       for k=1:labelsSz
           if(labels(k) ==1)
               Pos = Pos + 1;
           else
               Neg = Neg + 1;
           end            
       end 
       if(Pos > Neg)
           randClassification = 1 ;
       else 
           randClassification = 0;
       end 
       
      if (isempty(attributes))
        classification = randClassification; 
        Node = struct(f1, d_stump, f2, left, f3, right, f4, classification);
      else
        [attrSize, ~] = size(attributes);
        gainMax=0;
        attr = 0;
        Sv1=[];
        Sv2=[];
        LabelsSv1=[];
        LabelsSv2=[];
        weights1=[];
        weights2=[];      
       
        %Test Gain function to find attribute to test 
        %attrSize
        for i=1:attrSize 
            %data
           % i
            %labels
            [tempGain,tempSv1,tempSv2, tempLabelsSv1, tempLabelsSv2,...
                tempweights1,tempweights2, classifierT]...
                    = Gain(data, weights, labels, i);
                %{
           gainMax
           tempGain
           tempSv1
           tempSv2
           tempLabelsSv1
           tempLabelsSv2
           tempweights1
           tempweights2
                    %}
                  % tempGain
                  % gainMax 
                   
             if(tempGain > gainMax)
                 gainMax = tempGain;
                 attr = i;
                 Sv1 = tempSv1;
                 Sv2 = tempSv2; 
                 LabelsSv1 = tempLabelsSv1;
                 LabelsSv2 = tempLabelsSv2; 
                 weights1 = tempweights1;
                 weights2 = tempweights2;  
                 d_stump = classifierT;
             end 
        end 
        
        
       
            if(isempty(Sv1)==1)
                left = struct(f1, d_stump, f2, left, f3, right, f4, randClassification);
            else 
               % Sv1
               % weights1
               % LabelsSv1
               % attrUpdated
               attrUpdated = attributes(:,:);     
                  attrUpdated(attr,:) = [];   
                  
               left = ID3(Sv1, weights1, LabelsSv1, attrUpdated);
            end 
            
            if(isempty(Sv2)==1)
                right = struct(f1, d_stump, f2, left, f3, right, f4, randClassification);
            else 
                attrUpdated = attributes(:,:);     
                 attrUpdated(attr,:) = []; 
                 
                right = ID3(Sv2, weights2, LabelsSv2, attrUpdated);
            end 

            Node = struct(f1, d_stump, f2, left, f3, right, f4, classification);

       end  

end 
    
    
end 
 



