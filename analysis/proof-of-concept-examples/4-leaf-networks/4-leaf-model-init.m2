-- JC Model for any four leaf networks
leafPattern4L = {(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),
     (C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
numericLabeling4L = hashTable{A => 0, C => 1, G => 2, T => 3};
groupLabeling4L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
leafPatternDict4L = getLeafPatternDict(leafPattern4L,numericLabeling4L,groupLabeling4L);


