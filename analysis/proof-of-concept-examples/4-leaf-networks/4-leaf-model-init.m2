-- JC Model for any four leaf networks
leafPattern4L = {(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),
     (C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
groupLabeling4L = hashTable{A => 0, C => 1, G => 2, T => 3};
fourierIndices4L = getFourierIndices(leafPattern4L,groupLabeling4L);


