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

addEdge = method()
addEdge (List, List) := (network, EP) -> (
    -- Network should be given as a pair = {edge list, reticulation pair list}.
    -- EP should be the two edges that will be subdivided in order to add a new
    -- edge. New reticulation will be on the second edge listed in EP.
    m = max flatten network_0;
    edge1 = EP_0;
    edge2 = EP_1;
    edgesToAdd = { {edge1_0, m + 1}, {edge1_1, m+1}, {edge2_0, m+2}, {edge2_1, m+2}, {m+1, m+2} };
    newReticulations = {{{m +1, m+2}, {edge2_0, m+2}}};
    newNetworkEdges = delete(EP_0, network_0);
    newNetworkEdges = delete(EP_1, newNetworkEdges);
    newNetworkEdges = newNetworkEdges | edgesToAdd;
    newNetwork = {newNetworkEdges, network_1 | newReticulations};
    newNetwork )




fourLeafParameterization = method() 
fourLeafParameterization (List, Boolean) := (network, includeQs) -> (
    -- Compute the parameterization of a 4-leaf network under the JC model.
    -- Input is a network, which is a list {edge list, reticulation list}, and a
    -- boolean variable includeQs, which specifies whether or not to include the
    -- q variables in the output.
    nLeaves = 4;
    y = hashTable{A => 0, C => 1, G => 2, T => 3};
    L={(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),
        (C,A,G,T),(C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),
        (C,G,G,C)};
    EPList = network_0;
    reticulationPairlist = network_1;
    EPListSorted = sort apply(#EPList, j -> sort EPList#j);
    varList = flatten(
        apply(#EPListSorted, j ->{e_(EPListSorted#j), a_(EPListSorted#j), b_(EPListSorted#j)})) | toList(i_1..i_nLeaves);
    S = QQ[varList];
    varSqList = apply((gens S)_{0..3*(#EPListSorted)-1}, j -> j^2);
    R = S/(ideal varSqList);
    sigma = generateSigma(EPListSorted,nLeaves);
    RQ = R[toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2)))];
    if includeQs then (
        Eqn_1 = apply(L, j -> q_(y#(j#0),y#(j#1),y#(j#2)) - generateQ(sigma,reticulationPairList, j,EPListSorted));
        I = ideal Eqn_1;
        return gens I
        ) else (
        parameterization = apply(L,j -> generateQ(sigma,reticulationPairList,j,EPListSorted));
        return parameterization;
        )
    )


L={(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),
    (C,A,G,T),(C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),
    (C,G,G,C)};

computeDimensionNumerically = method()
computeDimensionNumerically (List) := (parameterization) -> (
    -- Compute the dimension of the parameterization numerically. Input takes
    -- the form of a parameterization without q's, i.e., of the form of the
    -- output of fourLeafParameterization with includeQs=false. Note: this
    -- function requires L to be defined, but should work for any number of
    -- leaves (not just 4) provided that L is defined for that.
    y = hashTable{A => 0, C => 1, G => 2, T => 3};
    qVars = apply(L,j -> q_(y#(j#0),y#(j#1),y#(j#2)));
    -- A = QQ[qVars]
    B = QQ[flatten(apply(#EPListSorted, j -> {a_(EPListSorted#j),b_(EPListSorted#j)}))]; -- all the parameters
    -- phi = map(B,A,apply(parameterization,j->sub(j,B)))
    -- toString parameterization
    W = flatten entries vars B;
    randomValues = apply(W, i-> i=> random QQ);
    parameterization=apply(parameterization, i->sub(i, B));
    J1 = jacobian matrix{parameterization};
    J0 = sub(J1, randomValues);
    out = rank J0;
    return out;
    )


end

-- Start by evaluating these lines:
restart; 
printWidth=10000; 
load "computeParameterization.m2"; 


-- Define your network
edgePairList = {{1,5},{5,10},{2,12},{10,12},{7,12},{6,10},{6,7},{7,9},{6,8},{8,9},{4,11},{5,11}, {3,8},{9,11}};
reticulationPairList = { {{6,7},{7,12}}, {{5,11},{9,11}}, {{6,8},{8,9}}};
network = {edgePairList, reticulationPairList}


-- Next, compute the parameterization
p = fourLeafParameterization(network,false); 

-- Compute the dimension 
computeDimensionNumerically(p)

-- Example usage of addEdge:
network1=addEdge(network,{{1,5},{2,12}})
p1 = fourLeafParameterization(network1,false);
computeDimensionNumerically(p1)

-- this example is weird because adding a reticulation reduces the dimension ¯\(ツ)/¯.
