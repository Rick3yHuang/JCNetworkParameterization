needs "ParametrizationGeneration.m2"
-- Inputs:
-- JC Model
y = hashTable{A => 0, C => 1, G => 2, T => 3}
L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)}
M = getModel(L,y)
-- Network
leaves = {1,2,3}
EPList = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
EPListSorted = sort apply(#EPList, j -> sort EPList#j);
reticulationPairList = {{{4,6},{5,6}},{{6,7},{7,8}}};
N = getNetwork(EPListSorted,leaves,reticulationPairList,2)
end

restart
-- Start M2 buffer in one directory above
needs "TESTS/Test-Parameter-Generation.m2"
nLeaves = #(getLeaves N)
varList = flatten(apply(#EPListSorted, j -> {e_(EPListSorted#j),a_(EPListSorted#j),b_(EPListSorted#j)}))|toList(i_1..i_nLeaves);
S = QQ[varList]
varSqList = apply((gens S)_{0..3*(#EPListSorted)-1}, j -> j^2)
R = S/(ideal varSqList)
sigma = generateSigma N
RQ = R[toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2)))]x
-- Without q's
param_0 = apply(L,eq -> generateQ(sigma,N,seq))
dim ideal param_0
qVars = apply(L,j -> q_(y#(j#0),y#(j#1),y#(j#2)))
A = QQ[qVars]
B = QQ[flatten(apply(#EPListSorted, j -> {a_(EPListSorted#j),b_(EPListSorted#j)}))]
phi = map(B,A,apply(param_0,j->sub(j,B)))

-*
-- With q's
Eqn_1 = apply(L,j -> q_(y#(j#0),y#(j#1),y#(j#2)) - generateQ(sigma,reticulationPairList,j,EPListSorted))
I = ideal Eqn_1
dim I
*-
