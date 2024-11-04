restart
load "ParametrizationGeneration.m2"

y = hashTable{A => 0, C => 1, G => 2, T => 3}
-- Inputs:
nLeaves = 4
EPList = {{1,8},{7,8},{8,9},{6,7},{5,6},{5,9},{6,10},{5,10},{4,6},{2,5},{3,10}};
reticulationPairList = {{{6,7},{5,6}},{{5,10},{6,10}}};
L = {(A,A,A,A),(A,A,C,C),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),(C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T)};


-- Finding Parametrization:
EPListSorted = sort apply(#EPList, j -> sort EPList#j);
varList = flatten(apply(#EPListSorted, j -> {e_(EPListSorted#j),a_(EPListSorted#j),b_(EPListSorted#j)}))|toList(i_1..i_nLeaves);
S = QQ[varList]
varSqList = apply((gens S)_{0..3*(#EPListSorted)-1}, j -> j^2)
R = S/(ideal varSqList)
sigma = generateSigma(EPListSorted,nLeaves)
RQ = R[toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2)))]
-- Without q's
param_0 = apply(L,j -> generateQ(sigma,reticulationPairList,j,EPListSorted))
dim ideal param_0
Eqn_1 = apply(L,j -> q_(y#(j#0),y#(j#1),y#(j#2)) - generateQ(sigma,reticulationPairList,j,EPListSorted))
EqnTex = texMath Eqn_1
