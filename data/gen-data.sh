#!/bin/bash
#Caution: only tested under Red Hat Enterprise Linux 6

DATAURL=https://archive.ics.uci.edu/ml/machine-learning-databases\
/iris/iris.data ;

NAMESURL=https://archive.ics.uci.edu/ml/machine-learning-databases\
/iris/iris.names ;

wget $NAMESURL ;
wget $DATAURL ;

#save the original data file
cp iris.data orig-iris.data ;

#change the flower species to the target class values 1,2,and 3
sed -i -e 's/Iris-setosa/1/g' iris.data ;
sed -i -e 's/Iris-versicolor/2/g' iris.data ;
sed -i -e 's/Iris-virginica/3/g' iris.data ;

#strip trailing newline => each line, one sample
head -c -1 iris.data > cleaned-iris.data ;


#depending on system, sed or repeated downloads may generate
#unnecessary extra files, also removes og iris file from web
rm iris.data* iris.data-* 2> /dev/null
rm iris.names.* iris.names-* 2> /dev/null

#create 5 80-20 training and testing splits
mkdir training ;
mkdir testing ;

for i in {1..5}
do
  touch temp$i
  shuf cleaned-iris.data > temp$i ;
  head -n 120 temp$i > train$i.data ;
  tail -n 30 temp$i > test$i.data ;
  rm temp$i;
  mv train$i.data training ;
  mv test$i.data testing ;
done

