function [ Gain1, Sv1, Sv2, LabelsSv1, LabelsSv2, weights1, weights2,...
   classifier ] = Gain(data, weights, labels, attr  )
%{
    Function to calculate the Gain from testing a data set with
    corresponding labels for a certain Attribute 
        -the attribute determines the input of Data 
            -ie Attribute 1 tests 1st column of our data, so data = S(:,1)

    Inputs
        1. Dataset data 
            =Nx1 vector 
        2. weights 
            -used in the decision_stump 
        3. labels 
            -Nx1 vector of binary class labels 
        4. attr 
            -the attribute (column of the data) we wish to test
    Outputs 
        1. Gain 
            -the gain from splitting the data according to the Attribute
            tested 
%}

[DataRows, DataColumns] = size(data);
Sv1 = zeros(DataRows, DataColumns);
Sv2 = zeros(DataRows, DataColumns);
LabelsSv1 = zeros(DataRows, 1);
LabelsSv2 = zeros(DataRows, 1);
weights1 = zeros(DataRows, 1);
weights2 = zeros(DataRows, 1);
%data
%weights
%labels
[classifier, ~] = decision_stump(data(:,attr), weights, labels);
l1Iterator=1;
l2Iterator=1;
w1It=1;
w2It=1;
for i=1:DataRows 
   %classifier(data(i))
    if(classifier(data(i,attr))==1)
        Sv1(l1Iterator,:)=data(i,:);
        LabelsSv1(l1Iterator,:) = labels(i,:);
        l1Iterator=l1Iterator+1;
        weights1(w1It,:) = weights(i,:);
        w1It = w1It + 1;
    else
        Sv2(l2Iterator,:)=data(i,:);
        LabelsSv2(l2Iterator,:)=labels(i,:);
        l2Iterator=l2Iterator+1;
         weights2(w2It,:) = weights(i,:);
        w2It = w2It + 1;
    end     
end 

%Sv1
%Sv2
%[testSzSv1,~] = size(Sv1)
%DataSize
%Sv1
%Getting rid of zeros in the elements for unassigned parts of the vector
%{
for i=DataSize:1 
    if(Sv1(i,:)==0)
        Sv1(i,:)=[];
        LabelsSv1(i,:)=[];
    end 
    if(Sv2(i,:)==0)
        Sv1(i,:)=[];
        LabelsSv2(i,:)=[];
    end 
end
%}
%i1 = find(Sv1,1,'first');


i2 = find(Sv1(:,1),1,'last');
Sv1 = Sv1(1:i2, :);

LabelsSv1 = LabelsSv1(1:i2,:);
weights1 = weights1(1:i2,:);

%i1=find(Sv2,1,'first');
i2=find(Sv2(:,1),1,'last');
Sv2 = Sv2(1:i2,:);
LabelsSv2 = LabelsSv2(1:i2,:);
weights2=weights2(1:i2,:);

%Sv1
%Sv2


%Calculating Sum of Entropies of the sets 
%Sv1
%LabelsSv1
%Sv2
%LabelsSv2
[EntropySv1] = Entropy(LabelsSv1);
[EntropySv2] = Entropy(LabelsSv2);
[EntropyS] = Entropy(labels);

[SizeSv1,~] = size(Sv1);
[SizeSv2,~] = size(Sv2);

%Sv1
%Sv2
%calculating Gain 
Gain1 = EntropyS - (SizeSv1/DataRows)*EntropySv1 - (SizeSv2/DataRows)*EntropySv2;
end

