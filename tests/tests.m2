(
    testDirectory := toAbsolutePath currentFileDirectory;

    -- One regression test per ground-truth file.
    scan({"3-leaf-level-2.txt", "4-leaf-level-1.txt", "4-leaf-level-2.txt"}, file -> (
	    TEST ("load " | format(testDirectory | file) | ";\n" | ///
		N = getNetwork(fixtureEdges,fixtureLeaves,fixtureReticulationPairs);
		patterns = getLeafPatternDict(fixturePatterns,
		    hashTable{A=>0,C=>1,G=>2,T=>3},
		    hashTable{A=>{0,0},C=>{0,1},G=>{1,0},T=>{1,1}});

		-- Identify the function's local variables with the reference-ring variables.
		importFrom("JCNetworkParameterization", "findVariable");
		mapToReference = polys -> (
		    referenceVars := gens fixtureRing;
		    phi := map(fixtureRing,ring first polys,
			apply(gens ring first polys,
			    v -> findVariable(referenceVars, toString v)));
		    apply(polys,f -> phi f)
		    );

		actual = toList computeParameterization(N,patterns,includeQs=>false);
		assert(mapToReference(actual) == expectedCoordinates);

		actual = toList computeParameterization(N,patterns,includeQs=>true);
		assert(mapToReference(actual) == expectedRelations);

		actual = toList computeParameterization(N,patterns);
		assert(mapToReference(actual) == expectedRelations);
		///);
	    ));

    );

-- generateSigma: hand-computed paths on a four-leaf tree.
TEST ///
importFrom("JCNetworkParameterization", "generateSigma");
N = getNetwork({{1,5},{2,5},{3,6},{4,6},{5,6}}, {1,2,3,4}, {});
S = QQ[e_{1,5},e_{2,5},e_{3,6},e_{4,6},e_{5,6},p_1,p_2,p_3,p_4];
R = S/ideal(e_{1,5}^2,e_{2,5}^2,e_{3,6}^2,e_{4,6}^2,e_{5,6}^2);

expected = transpose matrix{{
    p_1, p_2, p_3, p_4,
    p_1*e_{1,5} + p_2*e_{2,5} + (p_3*e_{3,6} + p_4*e_{4,6})*e_{5,6},
    p_3*e_{3,6} + p_4*e_{4,6} + (p_1*e_{1,5} + p_2*e_{2,5})*e_{5,6}
    }};
assert(generateSigma(N,R) == expected);
///

-- generateSigma: traversing a triangle in either direction gives the same
-- monomial. Its coefficient must be one, and repeated edges contribute zero.
TEST ///
importFrom("JCNetworkParameterization", "generateSigma");
N = getNetwork({{1,4},{2,5},{3,6},{4,5},{4,6},{5,6}},
    {1,2,3}, {{{4,6},{5,6}}});
S = QQ[e_{1,4},e_{2,5},e_{3,6},e_{4,5},e_{4,6},e_{5,6},p_1,p_2,p_3];
R = S/ideal(e_{1,4}^2,e_{2,5}^2,e_{3,6}^2,e_{4,5}^2,e_{4,6}^2,e_{5,6}^2);

cycleMonomial = e_{4,5}*e_{4,6}*e_{5,6};
expected = transpose matrix{{
    p_1, p_2, p_3,
    p_1*e_{1,4}*(1+cycleMonomial)
        + p_2*e_{2,5}*(e_{4,5}+e_{5,6}*e_{4,6})
        + p_3*e_{3,6}*(e_{4,6}+e_{5,6}*e_{4,5}),
    p_2*e_{2,5}*(1+cycleMonomial)
        + p_1*e_{1,4}*(e_{4,5}+e_{4,6}*e_{5,6})
        + p_3*e_{3,6}*(e_{5,6}+e_{4,6}*e_{4,5}),
    p_3*e_{3,6}*(1+cycleMonomial)
        + p_1*e_{1,4}*(e_{4,6}+e_{4,5}*e_{5,6})
        + p_2*e_{2,5}*(e_{5,6}+e_{4,5}*e_{4,6})
    }};
assert(generateSigma(N,R) == expected);
///

-- generateQ: use a hand-written Sigma, independently of generateSigma.
-- Vertex 5 is an unlabeled tip in a retained tree: cutting {4,5} leaves
-- an empty labeled-leaf component, so that edge always contributes a_{4,5}.
TEST ///
importFrom("JCNetworkParameterization", "generateQ");
N = getNetwork({{1,4},{2,6},{3,6},{4,5},{4,6}}, {1,2,3}, {});
S = QQ[e_{1,4},a_{1,4},b_{1,4},
       e_{2,6},a_{2,6},b_{2,6},
       e_{3,6},a_{3,6},b_{3,6},
       e_{4,5},a_{4,5},b_{4,5},
       e_{4,6},a_{4,6},b_{4,6},p_1,p_2,p_3];
R = S/ideal apply(take(gens S,15), v -> v^2);

sigma4 = p_1*e_{1,4} + (p_2*e_{2,6}+p_3*e_{3,6})*e_{4,6};
sigma6 = p_2*e_{2,6}+p_3*e_{3,6} + p_1*e_{1,4}*e_{4,6};
sigma = transpose matrix{{p_1,p_2,p_3,sigma4,sigma4*e_{4,5},sigma6}};
patterns = getLeafPatternDict({(A,A,A),(A,C,C),(C,A,C),(C,G,T)},
    hashTable{A=>0,C=>1,G=>2,T=>3},
    hashTable{A=>{0,0},C=>{0,1},G=>{1,0},T=>{1,1}});

assert(generateQ(sigma,N,(A,A,A),patterns)
    == a_{1,4}*a_{2,6}*a_{3,6}*a_{4,5}*a_{4,6});
assert(generateQ(sigma,N,(A,C,C),patterns)
    == a_{1,4}*b_{2,6}*b_{3,6}*a_{4,5}*a_{4,6});
assert(generateQ(sigma,N,(C,A,C),patterns)
    == b_{1,4}*a_{2,6}*b_{3,6}*a_{4,5}*b_{4,6});
assert(generateQ(sigma,N,(C,G,T),patterns)
    == b_{1,4}*b_{2,6}*b_{3,6}*a_{4,5}*b_{4,6});
///

-- addNetworkEdge: one addition, reversed input edges, and both choices of sink.
TEST ///
importFrom("JCNetworkParameterization", "getLeaves");
edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{5,8},{6,7},{7,8}};
oldPairs = {{{6,7},{7,8}}};
N = getNetwork(edges,{1,2,3,4},oldPairs);
expectedEdges = sort {
    {1,9},{2,10},{3,6},{4,5},{5,6},{5,8},{6,7},{7,8},
    {8,9},{7,10},{9,10}};

-- Choose an endpoint on the second edge: vertex 10 is the new reticulation.
N1 = addNetworkEdge(N,{{8,1},{7,2}},7);
assert(toList getEdges N1 == expectedEdges);
assert(toList getReticulationEdges N1 == oldPairs | {{{9,10},{7,10}}});
assert(getLeaves N1 == {1,2,3,4});

-- Choose an endpoint on the first edge: vertex 9 is the new reticulation.
N2 = addNetworkEdge(N,{{8,1},{7,2}},1);
assert(toList getEdges N2 == expectedEdges);
assert(toList getReticulationEdges N2 == oldPairs | {{{9,10},{1,9}}});
assert(getLeaves N2 == {1,2,3,4});

-- Adding edges must not mutate the input network.
assert(toList getEdges N == edges);
assert(toList getReticulationEdges N == oldPairs);
///

-- addNetworkEdge: batch addition, including an edge created by the first step.
TEST ///
importFrom("JCNetworkParameterization", "getLeaves");
N = getNetwork(
    {{1,8},{2,7},{3,6},{4,5},{5,6},{5,8},{6,7},{7,8}},
    {1,2,3,4}, {{{6,7},{7,8}}});
edgePairs = {{{8,1},{7,2}},{{9,1},{6,3}}};
endpoints = {7,1};
batch = addNetworkEdge(N,edgePairs,endpoints);
sequential = addNetworkEdge(
    addNetworkEdge(N,edgePairs#0,endpoints#0),edgePairs#1,endpoints#1);

expectedEdges = sort {
    {1,11},{2,10},{3,12},{4,5},{5,6},{5,8},{6,7},{7,8},
    {8,9},{7,10},{9,10},{9,11},{6,12},{11,12}};
expectedPairs = {{{6,7},{7,8}},{{9,10},{7,10}},{{11,12},{1,11}}};
assert(toList getEdges batch == expectedEdges);
assert(toList getReticulationEdges batch == expectedPairs);
assert(getLeaves batch == {1,2,3,4});
assert(getEdges batch == getEdges sequential);
assert(getReticulationEdges batch == getReticulationEdges sequential);
assert(getLeaves batch == getLeaves sequential);
///

-- computeDimensionNumerically: known dimensions with constant Jacobian rank.
-- These assertions hold at every sample point, so randomness cannot cause failure.
TEST ///
R = QQ[x,y,z];
assert(computeDimensionNumerically {x,y,z} == 3);
assert(computeDimensionNumerically {x,2*x,x+1} == 1);
assert(computeDimensionNumerically {x,y,x*y} == 2);
assert(computeDimensionNumerically {0_R,1_R} == 0);
///
