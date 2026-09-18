--------------------------------------------------------------------------------------------
-*---Compute the parameterization of a network under a given model--------------------------
--------------------------------------------------------------------------------------------
Input: 
N	    -- a network of Network type
FI	    -- Fourier coordinates indexing info of the model of FourierIndices type
Optional Input:
includeQs -- a Boolean variable which specifies whether or not to include the Fourier
coordinates in the output
    
Output: polynomials representing the parameterization.
If includeQs is true, then the polynomials are in the ring with variables a, b, and q's.
If includeQs is false, then the polynomials are in the ring only with variables a and b's.
-------------------------------------------------------------------------------------------
*------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
computeParameterization = method(Options => {includeQs => true}) 
computeParameterization (Network, LeafPatternDict) := o-> (N,leafPatternDict) -> (
    a := local a;
    b := local b;
    e := local e;
    i := local i;
    q := local q;
    nLeaves := #(getLeaves N);
    numericLabeling := getNumericLabeling leafPatternDict;     -- the group labeling for the model
    leafPatterns := getLeafPatternClasses leafPatternDict;     -- the leaf pattern classes for the model
    reticulations := getReticulationEdges N;		       -- the reticulation edges for the network
    edges := getEdges N;				       -- the edges of the network

    -- Rings construction
    varList := flatten(apply(#edges, j -> {e_(edges#j), a_(edges#j), b_(edges#j)})) | toList(i_1..i_nLeaves);
    S := QQ[varList]; -- this ring contains variables e, a, and b, each indexed by the edges
    -- Constructing the boolean (quotient) ring R = QQ[e_,a_,b_,i_]/(e_^2, a_^2, b_^2, i_^2)
    varSqList := apply((gens S)_{0..3*(#edges)-1}, j -> j^2);
    R := S/(ideal varSqList);
    -- output ring AB contains only the a and b variables
    AB := QQ[flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))];
    -- Adding the Fourier coordinates (the q-variables) to the ring
    fourierCoordinates := toList apply(leafPatterns,j-> q_(toSequence apply(#j, k -> numericLabeling#(j#k)))); 
    ABQ := QQ[fourierCoordinates,flatten(apply(#edges, j -> {a_(edges#j),b_(edges#j)}))];
    
    sigma := generateSigma(N,R);
    parameterization := apply(leafPatterns,j -> generateQ(sigma,N,j,leafPatternDict));
    out := apply(parameterization, f -> sub(f,AB));
    if o#includeQs then (
	out = apply(#leafPatterns, j ->
	    findVariable(flatten entries vars ABQ, toString fourierCoordinates#j) - sub(parameterization#j,ABQ)
	    );
	);
    out
    )

--------------------------------------------------------------------------------------------
-*---This function generates the state matrix for a given network N in the ring R.----------
-----This is a subroutine for computeParameterization.--------------------------------------
--------------------------------------------------------------------------------------------
Input:
N       -- a network of Network type
R       -- the path ring in which sigma is computed
Output:
a state matrix sigma in R representing the states at each node of the network N
--------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
generateSigma = method()
generateSigma (Network,Ring) := (N,R) -> (
    Rvars := flatten entries vars R;
    edgePairListSorted := getEdges N;
    numLeaves := #(getLeaves N);
    numVertices := #(unique flatten  edgePairListSorted);
    leafEdgeList := edgePairListSorted_{0..numLeaves-1};
    edgeList := edgePairListSorted_{numLeaves..#edgePairListSorted - 1};
    matA := mutableIdentity(R,numVertices);
    for i from 0 to numVertices-1 do matA_(i,i) = 0; -- initiate a mutable matrix A with all entries 0
    -*
    The following two lines of code construct an adjacent matrix A with e_ij on the leaf 
    positions (A_ij) and e_kl on the internal edges positions (both A_kl and A_lk)
    *-
    scan(#leafEdgeList,j -> (
	    pair := leafEdgeList_j;
	    matA_(pair_1-1,pair_0-1) = findVariable(Rvars,concatenate("e_",toString pair));
	    ));
    scan(#edgeList,k -> (
	    pair := edgeList_k;
	    matA_(pair_1-1,pair_0-1) = findVariable(Rvars,concatenate("e_",toString pair));
	    matA_(pair_0-1,pair_1-1) = findVariable(Rvars,concatenate("e_",toString pair));
	    ));
    -- v is the initial state with first nleaves entries (i_leafIndex) and 0 otherwise 
    v := transpose matrix{Rvars_{-numLeaves..-1}|apply(numVertices-numLeaves,j -> 0)};
    -- Find sigma
    sigma := mutableMatrix sub(v,R);
    w := mutableMatrix sub(v,R);
    for j from 1 to #edgePairListSorted do (
	w = matA*w;
	if w == 0 then break;
	sigma = sigma + w;
	);
    transpose matrix{apply(numRows sigma, j -> sum flatten entries (coefficients sigma_(j,0))_0)}
    )

--------------------------------------------------------------------------------------------
-*----------------- Given a leaf pattern P (e.g. AAAA or ACGT), ----------------------------
------------------- generate the Fourier coordinates for q_P of network N ------------------
--------------------------------------------------------------------------------------------
Input:
sigma	   -- the state matrix generated by generateSigma
N		   -- a network of Network type
leafPattern	   -- a leaf assignment (e.g. AAAA or ACGT) 
leafPatternDict -- a LeafPatternDict object containing the leaf patterns and group labeling
Output:
a polynomial in R representing the Fourier coordinate q_P of network N
--------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
generateQ = method()
generateQ (Matrix,Network,Sequence,LeafPatternDict) := (sigma,N,leafPattern,leafPatternDict) -> (
    R := ring sigma;
    Rvars := flatten entries vars R;
    reticulationPairList := getReticulationEdges N;
    edgePairListSorted := getEdges N;
    groupLabeling := getGroupLabeling leafPatternDict;
    -- Make group sum map based on leafPattern and group labeling
    phi := makeGroupSumMap(leafPattern,groupLabeling,R);
    -- Look up ring elements
    reticulationPairs := apply(reticulationPairList,j->apply(j,l->findVariable(Rvars,concatenate("e_",toString l))));
    edgeData := apply(edgePairListSorted, endpoints -> (
	    {endpoints,
		findVariable(Rvars,concatenate("e_",toString endpoints)),
		findVariable(Rvars,concatenate("a_",toString endpoints)),
		findVariable(Rvars,concatenate("b_",toString endpoints))
		}
	    ));
    k := getLevel N;
    -- Choose one incoming edge to discard at each reticulation.
    -- output is a list of all 2^k possible sets of reticulation edges to discard
    discardedReticulationSets := apply(2^k,j -> (
	    apply(k, reticulationPairIndex -> (
		    bit := floor(j/2^reticulationPairIndex) % 2;
		    reticulationPairs#reticulationPairIndex#bit
		    ))));
    
    out := 0_R;
    -- Loop through all 2^k possible display trees
    for discardedReticulations in discardedReticulationSets do (
	-- Create display tree by only keep the edges that are not discarded
	remainingEdgeData := select(edgeData,data -> not member(data#1,discardedReticulations));
	-- rule for substituting 0 for the discarded edges in sigma
	discardRule := apply(discardedReticulations,discardedEdge -> discardedEdge => 0);
	-- apply the discard rule to sigma to get the state matrix for the display tree
	treeSigma := sub(sigma,discardRule);
	-- rule for substituting 1 for the retained edges in sigma
	retainEdgeRule := apply(remainingEdgeData,data -> data#1 => 1);

	prod := 1_R;
	-- Loop through all edges in the display tree
	for cutData in remainingEdgeData do (
	    endPoints := cutData#0;
	    cutEdge := cutData#1;
	    aParam := cutData#2;
	    bParam := cutData#3;
    
	    (v,w) := toSequence endPoints;
	    -- Cut the current edge to separate the two components.
	    sigmaV := sub(treeSigma_(v-1,0),{cutEdge => 0});
	    sigmaW := sub(treeSigma_(w-1,0),{cutEdge => 0});
	    edgeParam := aParam;
	    -- If either component contains no labeled leaves, use a_{u,v}.
	    if (sigmaV != 0 and sigmaW != 0) then (
		-- Evaluate a group sum from one side using the precomputed ring map.
		leafSumV := sub(sigmaV,retainEdgeRule);
		groupSumV := evaluateGroupSum(leafSumV,phi);
		-- If group element is (0,0) → use a_{v,w}, else b_{v,w}
		if (groupSumV != {0,0}) then (
		    edgeParam = bParam;
		    );
		);
	    prod = prod*edgeParam;
	    );
	out = out + prod;
	);
    out
    )

--------------------------------------------------------------------------------------------
-- Helpers----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- make group sum map based on the group labeling for a given leaf assignment (e.g. AAAA or ACGT)
makeGroupSumMap = method()
makeGroupSumMap (Sequence,HashTable,Ring) := (leafPattern,groupLabeling,R) -> (
    x := local x;
    y := local y;
    S := QQ[x,y];

    nLeaves := #leafPattern;
    Rvars := flatten entries vars R;

    leafImages := apply(toList leafPattern,nucleotide -> (
	    groupLabel := groupLabeling#nucleotide;	 -- e.g. {0,1} for nucleotide C
	    (groupLabel#0)*x + (groupLabel#1)*y		 -- e.g. 0*x + 1*y = y for nucleotide C
	    ));

    images := apply(#Rvars - nLeaves, j -> 0_S) | leafImages;
    map(S,R,images)
    )

-- Evaluate the group sum of based on a ring map phi
evaluateGroupSum = method()
evaluateGroupSum (RingElement,RingMap) := (leafSum,phi) -> (
    -- e.g. under ACGT, g_2+g_4 -> {0,1} + {1,1} = {1,2} -> x+2y
    groupSumInS := phi leafSum;
    -- e.g. x+2y -> {1,2} -> {1,0} in Z_2 x Z_2
    coordinates := flatten entries vars ring groupSumInS;
    apply(coordinates, z -> lift(coefficient(z,groupSumInS),ZZ) % 2)
    )

-- variable lookup: variable (string) -> variable (ring element) in ring defined locally
findVariable = method()
findVariable(List,String) := (varList,varString) -> (
    first select(varList,x -> toString x == varString)
    )

--------------------------------------------------------------------------------------------
-- Add reticulations to a network ----------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Function for constructing networks by adding reticuations

-- This can be run in two modes, either (1) by adding one reticulation at a
-- time, or (2) by adding multiple reticulations at once.
addNetworkEdge = method()
addNetworkEdge (Network,List,ZZ) := (N,edgesToDivide,vertexInNewReticulation) -> (
    edges := getEdges N; reticulationEdges := getReticulationEdges N;
    leaves := getLeaves N; level := getLevel N;
    numVertices := max flatten edges;
    -- make sure that the edges to divide are not reticulation edges
    scan(edgesToDivide,e -> assert(#select(reticulationEdges,r -> r_0 == e or r_1 == e) == 0));
    (edgeToDivide1,edgeToDivide2) := toSequence edgesToDivide;
    edgesToAdd := {{edgeToDivide1_0,numVertices+1},{edgeToDivide1_1,numVertices+1},
	{edgeToDivide2_0,numVertices+2},{edgeToDivide2_1,numVertices+2},
	{numVertices+1,numVertices+2}};
    if #(select(edgeToDivide1,v -> v == vertexInNewReticulation)) != 0 then(
	newReticulationEdges := {{{numVertices+1,numVertices+2},{vertexInNewReticulation,numVertices+1}}};
	) else (
	newReticulationEdges = {{{numVertices+1,numVertices+2},{vertexInNewReticulation,numVertices+2}}};
	);
    newEdges := delete(sort edgeToDivide2,edges);
    newEdges = delete(sort edgeToDivide1,newEdges);
    newEdges = newEdges | edgesToAdd;
    getNetwork(newEdges,leaves,reticulationEdges|newReticulationEdges)
    )
-* Here's an example of how to use addEdge:
edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulations = {{{6,7},{7,8}}};
leaves = {1,2,3,4};
exampleNetwork = getNetwork(edges,leaves,reticulations)
exampleNetwork2 = addNetworkEdge(exampleNetwork,{{1,8},{7,2}},7)
peek oo
*-

-- alternative run mode 
addNetworkEdge (Network,List,List) := (N,edgesToDivideList,vertexInNewReticulationList) -> (
    outNetwork := N;
    scan(#edgesToDivideList,i -> outNetwork = addNetworkEdge(outNetwork,edgesToDivideList_i,vertexInNewReticulationList_i));
    outNetwork
    )
-* Here's an example of how to use addEdge:
edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulations = {{{6,7},{7,8}}};
leaves = {1,2,3,4};
exampleNetwork = getNetwork(edges,leaves,reticulations)
exampleNetwork2 = addNetworkEdge(exampleNetwork,{{{1,8},{7,2}},{{3,6},{4,5}}},{7,3})
peek oo
*-



-------------------------------------------------------------
-- Compute variety dimension numerically---------------------
-------------------------------------------------------------

-*
This function computes the dimension of a parameterization numerically
Input: 
parameterization	  -- a list of polynomials representing the parameterization
(the form of a parameterization without q's, i.e., of
    the form of the output of fourLeafParameterization with
    includeQs=false)
Output: 
the dimension of the parameterized variety
*-
computeDimensionNumerically = method()
computeDimensionNumerically List := parameterization -> (
    edgeVariable := flatten entries vars (ring parameterization_0);
    randomValues := flatten entries random(QQ^(#edgeVariable),QQ^1);
    randomValuesSubOptions := apply(#edgeVariable, j -> edgeVariable#j => randomValues#j);
    jac := jacobian matrix{parameterization}; -- compute the symbolic jacobian
    evaluatedJac := sub(jac, randomValuesSubOptions); -- substitute in the random variables
    rank evaluatedJac    
    )

end
