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
    -- edge. New reticulation will be on the second edge listed in EP. NOTE: the
    -- direction of the reticulation is determined by whether the second edge in
    -- EP is input as {x,y} or {y,x}. Last updated: 2024-10-22 by mh
    m = max flatten network_0;
    edge1 = EP_0;
    edge2 = EP_1;
    edge1Reversed = {EP_0#1,EP_0#0};
    edge2Reversed = {EP_1#1,EP_1#0};
    edgesToAdd = { {edge1_0, m + 1}, {edge1_1, m+1}, {edge2_0, m+2}, {edge2_1, m+2}, {m+1, m+2} };
    newReticulations = {{{m +1, m+2}, {edge2_0, m+2}}};
    newNetworkEdges = delete(edge1, network_0);
    newNetworkEdges = delete(edge1Reversed, newNetworkEdges);
    newNetworkEdges = delete(edge2, newNetworkEdges);
    newNetworkEdges = delete(edge2Reversed, newNetworkEdges);
    newNetworkEdges = newNetworkEdges | edgesToAdd;
    newNetwork = {newNetworkEdges, network_1 | newReticulations};
    newNetwork )
-- -- COMMENTARY: Here's an example of how to use addEdge:
-- edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
-- reticulations = {{{6,7},{7,8}}};
-- exampleNetwork = {edges,reticulations}
-- exampleNetwork2 = addEdge(exampleNetwork,{{1,8},{7,2}}) 
-- p = fourLeafParameterization(exampleNetwork2, false)

fourLeafParameterization = method() 
fourLeafParameterization (List, Boolean) := (network, includeQs) -> (
    -- Compute the parameterization of a 4-leaf network under the JC model.
    -- Input is a network, which is a list {edge list, reticulation list}, and a
    -- boolean variable includeQs, which specifies whether or not to include the
    -- Fourier coordinates in the output. Last updated 2024-10-22 by mh
    nLeaves = 4;
    y = hashTable{A => 0, C => 1, G => 2, T => 3};
    L={(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),(C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
    reticulations = network_1;
    edges = network_0;
    edges = sort apply(#edges, j -> sort edges#j); -- sort the edges
    varList = flatten(apply(#edges, j -> {e_(edges#j), a_(edges#j), b_(edges#j)})) | toList(i_1..i_nLeaves); -- make a list of variables e, a, and b, each indexed by the edges
    S = QQ[varList];
    varSqList = apply((gens S)_{0..3*(#edges)-1}, j -> j^2); -- square the variables
    R = S/(ideal varSqList);
    sigma = generateSigma(edges,nLeaves); -- I don't know what this does
    parameterization = apply(L,j -> generateQ(sigma,reticulations,j,edges));
    if includeQs 
    then (
        fourierCoordinates = toList apply(L,i->q_(y#(i#0),y#(i#1),y#(i#2))); -- List out the fourier coordinates (the q-variables)
        BQ = QQ[fourierCoordinates,flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))]; -- ring with a's, b's and q's
        parameterization = apply(parameterization, f -> substitute(f,BQ));
        polynomials = apply(L, j -> q_(y#(j#0),y#(j#1),y#(j#2)) - generateQ(sigma,reticulations,j,edges)); -- define polynomials with q's in them
        return polynomials; ) 
    else (
         -- change the ring that the polynomials live in to have variables a's and b's (i.e., to use QQ[a...,b...] rather than QQ[a...,b..,e...,i...])
         B = QQ[flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))];
         parameterization = apply(parameterization, f -> substitute(f,B));
         return parameterization;
         )
     )

computeDimensionNumerically = method()
computeDimensionNumerically (List) := (parameterization) -> (
    -- Compute the dimension of the parameterization numerically. Input takes
    -- the form of a parameterization without q's, i.e., of the form of the
    -- output of fourLeafParameterization with includeQs=false. Note: this
    -- function requires L to be defined, but should work for any number of
    -- leaves (not just 4) provided that L is defined for that. Last updated
    -- 2024-10-22 by mh
    edgeVariables = flatten entries vars (ring p_0); -- recover the edge parameters used in the parameterization
    randomValues = apply(edgeVariables, i-> i=> random QQ);
    J1 = jacobian matrix{parameterization}; -- compute the symbolic jacobian
    J0 = sub(J1, randomValues); -- substitute in the random variables
    out = rank J0;
    return out;
    )

end


--------------------------------------------------------------------------------
                                -- START HERE --
--------------------------------------------------------------------------------

-- Start by evaluating these lines:
restart; 
printWidth=10000; 
load "computeParameterization.m2"; 

-- Define a network
edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulations = {{{6,7},{7,8}}};
network = {edges,reticulations}

-- Compute the parameterization (the true/false determines whether or not the
-- output includes the Fourier coordinates (i.e., the q's).
p = fourLeafParameterization(network,false)

-- Compute the dimension numerically
computeDimensionNumerically(p)

