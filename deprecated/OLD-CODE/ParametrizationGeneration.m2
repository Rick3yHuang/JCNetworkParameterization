generateSigma = method()
generateSigma (List,ZZ) := (EPListSorted,nLeaves) -> (
    numV := #(unique flatten  EPListSorted);
    leafList := EPListSorted_{0..nLeaves-1};
    edgeList := EPListSorted_{nLeaves..#EPListSorted - 1};
    A := mutableIdentity(R,numV);
    for i from 0 to numV-1 do A_(i,i) = 0;
    scan(leafList,pair -> A_(pair_1-1,pair_0-1)=e_pair);
    scan(edgeList,pair -> (
	    A_(pair_1-1,pair_0-1) = e_pair;
	    A_(pair_0-1,pair_1-1) = e_pair;
	    ));
    v := transpose matrix{toList (i_1..i_nLeaves)|apply(numV-nLeaves,j -> 0)};
    sigma = mutableMatrix v;
    for j from 1 to #EPListSorted do sigma = sigma + (A^j)*(mutableMatrix v);
    transpose matrix{apply(numRows sigma, j -> sum flatten entries (coefficients sigma_(j,0))_0)}
    )

generateQ = method()
generateQ (Matrix,List,Sequence,List) := (sigma,reticulationPairList,seq,EPListSorted) -> (
    reticulationPairs := apply(reticulationPairList,j->apply(j,l->e_l));
    (F1,F2) := iMap(seq,#EPListSorted);
    k := #reticulationPairs;
    discardedReticulation := apply(2^k,j -> apply(k,l -> reticulationPairs#l#(floor((j%(2^(l+1)))/(2^l)))));
    out = 0;
    edgeVars := apply(#EPListSorted, j -> e_(EPListSorted#j));
    for pair in discardedReticulation do (
	remainingEdges = edgeVars;
	for p in pair do remainingEdges = delete(p,remainingEdges);
	prod := 1;
	for e in remainingEdges do (
	    	endPoints := value substring(2,toString e);
		zeroEdges := apply(#pair,j -> pair#j => 0)|{e => 0};
		sigmaV := sub(sigma_(endPoints_0-1,0),zeroEdges);
    	    	sigmaW := sub(sigma_(endPoints_1-1,0),zeroEdges);
		if (sigmaV == 0 or sigmaW == 0) then (
		    prod = prod*a_endPoints;
		    )else(
	    	    oneEdges := apply(#remainingEdges,j -> remainingEdges#j => 1);
		    factorV := sub(sigmaV,oneEdges);
    	    	    factorW := sub(sigmaW,oneEdges);
		    element1 := F1 (factorV);
		    element2 := F2 (factorV);
		    if (element1 == 0_W and element2 == 0_W) then (
			prod = prod*a_endPoints
			)else(
			prod = prod*b_endPoints
			);
		    )		
	    );
	out = out + prod;
	--print out;
	);
   out
)

iMap = method()
iMap (Sequence,ZZ) := (seq,n) -> (
    W = ZZ/2;
    h1 := hashTable{A => 0_W, C => 0_W, G => 1_W, T => 1_W};
    h2 := hashTable{A => 0_W, C => 1_W, G => 0_W, T => 1_W};
    F1 := map(W,R,apply(3*n,j->0)|apply(toList seq,j -> h1#j));
    F2 := map(W,R,apply(3*n,j->0)|apply(toList seq,j -> h2#j));
    return (F1,F2);
    )

end

restart
load "ParametrizationGeneration.m2"
y = hashTable{A => 0, C => 1, G => 2, T => 3}
-- Inputs:
nLeaves = 3
EPList = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
reticulationPairList = {{{4,6},{5,6}},{{6,7},{7,8}}};
L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)}

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
