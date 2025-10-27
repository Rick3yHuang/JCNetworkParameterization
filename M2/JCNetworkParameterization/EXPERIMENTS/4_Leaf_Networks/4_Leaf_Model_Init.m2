-- JC Model for four leaves
y4L = hashTable{A => 0, C => 1, G => 2, T => 3}
L4L = {(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),
     (C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
M4L = getModel(L4L,y4L)
