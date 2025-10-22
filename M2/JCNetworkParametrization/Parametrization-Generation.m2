
-----------------------------------  Find Parametrization ----------------------------------------

-*
Compute the parameterization of a network under thea given model
Input: 
  N -- a network of Network type
  M -- a modle M of Model type
  includeQs -- a Boolean variable which specifies whether or not to include the Fourier coordinates in the output
Output: 
  polynomials representing the parametrization.
  If includeQs is true, then the polynomials are in the ring with variables a, b, and q's.
  If includeQs is false, then the polynomials are in the ring only with variables a and b's.
(Created by mh, modified by rh on 2024-11-04)
*-
computeParametrization = method() 
computeParametrization (Network, Model, Boolean) := (N,M,includeQs) -> (
    a := local a;
    b := local b;
    e := local e;
    i := local i;
    q := local q;
    nLeaves := #(getLeaves N);
    y := getConverter M;
    L := getRepresentatives M;
    reticulations := getReticulationEdges N;
    edges := getEdges N;
    varList := flatten(apply(#edges, j -> {e_(edges#j), a_(edges#j), b_(edges#j)})) | toList(i_1..i_nLeaves);
    S := QQ[varList]; -- this ring contains variables e, a, and b, each indexed by the edges
    varSqList := apply((gens S)_{0..3*(#edges)-1}, j -> j^2);
    R := S/(ideal varSqList); -- this quotient ring is the boolean ring created from S
    sigma := generateSigma(N,R); -- sigma is the state vector for each edge before deleting edges and evaluate
    if includeQs then (
        fourierCoordinates := toList apply(L,j->q_(y#(j#0),y#(j#1),y#(j#2))); -- List out the fourier coordinates (the q-variables)
        ABQ := QQ[fourierCoordinates,flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))]; -- ring with a's, b's and q's
        --parameterizationWithQ := apply(parameterization, f -> substitute(f,ABQ));
        parametrizationWithQ := apply(L, j -> sub(q_(y#(j#0),y#(j#1),y#(j#2)),ABQ) - sub(generateQ(sigma,N,j,R),ABQ)) -- define polynomials with q's in them
    ) else (
	 params := apply(L,j -> generateQ(sigma,N,j,R));
         -- change the ring that the polynomials live in to have variables a's and b's (i.e., to use QQ[a...,b...] rather than QQ[a...,b..,e...,i...])
         AB := QQ[flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))];
         parameterizationWithQ := apply(params, f -> sub(f,AB))
    )
)

generateSigma = method()
generateSigma (Network,Ring) := (N,R) -> (
    Rvars := flatten entries vars R;
    EPListSorted := getEdges N;
    nLeaves := #(getLeaves N);
    numV := #(unique flatten  EPListSorted);
    leafList := EPListSorted_{0..nLeaves-1};
    edgeList := EPListSorted_{nLeaves..#EPListSorted - 1};
    matA := mutableIdentity(R,numV);
    for i from 0 to numV-1 do matA_(i,i) = 0; -- initiate a mutable matrix A with all entries 0
    -*
    The following two lines of code construct an adjacent matrix A with e_ij on the leaf 
    positions (A_ij) and e_kl on the internal edges positions (both A_kl and A_lk)
    *-
    scan(#leafList,j -> (
        pair := leafList_j;
        matA_(pair_1-1,pair_0-1)=Rvars_(1+j*3);)
    );
    scan(#edgeList,k -> (
        pair := edgeList_k;
	    x := pair_0-1;
	    y := pair_1-1;
	    matA_(y,x) = Rvars_(#leafList+1+k*3);
	    matA_(x,y) = Rvars_(#leafList+1+k*3);
	    ));
    -- v is the initial state with first nleaves entries (i_leafIndex) and 0 otherwise 
    v := transpose matrix{Rvars_{-nLeaves..-1}|apply(numV-nLeaves,j -> 0)};
    -- Find sigma
    sigma := mutableMatrix sub(v,R);
    for j from 1 to #EPListSorted do sigma = sigma + (matA^j)*(mutableMatrix v);
    transpose matrix{apply(numRows sigma, j -> sum flatten entries (coefficients sigma_(j,0))_0)}
)

generateQ = method()
generateQ (Matrix,Network,Sequence,Ring) := (sigma,N,seq,R) -> (
    Rvars := flatten entries vars R;
    W := ZZ/2;
    reticulationPairList := getReticulationEdges N;
    EPListSorted := getEdges N;
    reticulationPairs := apply(reticulationPairList,j->apply(j,l->findVariable(Rvars,concatenate("e_",toString l))));
    (F1,F2) := iMap(seq,#EPListSorted,R);
    k := #reticulationPairs;
    discardedReticulation := apply(2^k,j -> apply(k,l -> reticulationPairs#l#(floor((j%(2^(l+1)))/(2^l)))));
    out := 0;
    edgeVariables := apply(#EPListSorted, j -> findVariable(Rvars,concatenate("e_",toString EPListSorted#j)));
    remainingEdges := null;
    for pair in discardedReticulation do (
	remainingEdges = edgeVariables;
	for p in pair do remainingEdges = delete(p,remainingEdges);
	prod := 1;
	for ed in remainingEdges do (
        endPoints := value substring(2,toString ed);
		zeroEdges := apply(#pair,j -> pair#j => 0)|{ed => 0};
		sigmaV := sub(sigma_(endPoints_0-1,0),zeroEdges);
        sigmaW := sub(sigma_(endPoints_1-1,0),zeroEdges);
		if (sigmaV == 0 or sigmaW == 0) then (
		        prod = prod*findVariable(Rvars,concatenate("a_",toString endPoints));
		    )else(
	    	    oneEdges := apply(#remainingEdges,j -> remainingEdges#j => 1);
		        factorV := sub(sigmaV,oneEdges);
                factorW := sub(sigmaW,oneEdges);
		        element1 := F1 (factorV);
		        element2 := F2 (factorV);
		        if (element1 == 0_W and element2 == 0_W) then (
			        prod = prod*findVariable(Rvars,concatenate("a_",toString endPoints))
			    )else(
			        prod = prod*findVariable(Rvars,concatenate("b_",toString endPoints))
			    );
		    )		
	    );
	out = out + prod;
	--print out;
	);
   out
)

iMap = method()
iMap (Sequence,ZZ,Ring) := (seq,n,R) -> (
    W := ZZ/2;
    h1 := hashTable{"representativeA" => 0_W, "representativeC" => 0_W, "representativeG" => 1_W, "representativeT" => 1_W};
    h2 := hashTable{"representativeA" => 0_W, "representativeC" => 1_W, "representativeG" => 0_W, "representativeT" => 1_W};
    F1 := map(W,R,apply(3*n,j->0)|apply(toList seq,j -> h1#("representative"|toString j)));
    F2 := map(W,R,apply(3*n,j->0)|apply(toList seq,j -> h2#("representative"|toString j)));
    return (F1,F2);
    )

addNetworkEdge = method()
addNetworkEdge (List, List) := (network, EP) -> (
    -- Network should be given as a pair = {edge list, reticulation pair list}.
    -- EP should be the two edges that will be subdivided in order to add a new
    -- edge. New reticulation will be on the second edge listed in EP. NOTE: the
    -- direction of the reticulation is determined by whether the second edge in
    -- EP is input as {x,y} or {y,x}. Last updated: 2024-10-22 by mh
    m := max flatten network_0;
    edge1 := EP_0;
    edge2 := EP_1;
    edge1Reversed := {EP_0#1,EP_0#0};
    edge2Reversed := {EP_1#1,EP_1#0};
    edgesToAdd := { {edge1_0, m + 1}, {edge1_1, m+1}, {edge2_0, m+2}, {edge2_1, m+2}, {m+1, m+2} };
    newReticulations := {{{m +1, m+2}, {edge2_0, m+2}}};
    newNetworkEdges := delete(edge1, network_0);
    newNetworkEdges = delete(edge1Reversed, newNetworkEdges);
    newNetworkEdges = delete(edge2, newNetworkEdges);
    newNetworkEdges = delete(edge2Reversed, newNetworkEdges);
    newNetworkEdges = newNetworkEdges | edgesToAdd;
    newNetwork := {newNetworkEdges, network_1 | newReticulations};
    newNetwork
)
-- -- COMMENTARY: Here's an example of how to use addEdge:
-- edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
-- reticulations = {{{6,7},{7,8}}};
-- exampleNetwork = {edges,reticulations}
-- exampleNetwork2 = addEdge(exampleNetwork,{{1,8},{7,2}}) 
-- p = fourLeafParameterization(exampleNetwork2, false)


computeDimensionNumerically = method()
computeDimensionNumerically (List) := (parameterization) -> (
    -- Compute the dimension of the parameterization numerically. Input takes
    -- the form of a parameterization without q's, i.e., of the form of the
    -- output of fourLeafParameterization with includeQs=false. Note: this
    -- function requires L to be defined, but should work for any number of
    -- leaves (not just 4) provided that L is defined for that. Last updated
    -- 2024-10-22 by mh
    edgeVariables := flatten entries vars (ring parameterization_0); -- recover the edge parameters used in the parameterization
    randomValues := apply(edgeVariables, i-> i=> random QQ);
    J1 := jacobian matrix{parameterization}; -- compute the symbolic jacobian
    J0 := sub(J1, randomValues); -- substitute in the random variables
    out := rank J0
    )

findVariable = method()
findVariable(List,String) := (varList,varString) -> (
    first select(varList,x -> toString x == varString)
)
