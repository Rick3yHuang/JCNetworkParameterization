buildSpiral = method();
buildSpiral ZZ := r -> (
    if r < 1 then error "r must be at least 1";
    if r > 7 then (
	<< "-- Please specify reticulation events for r > 7 in spiral-network-constructor.m2" << endl;
	<< "-- and rerun the script." << endl;
	error "Only have information of level-1 to 7 spiral networks";
	);
    N := getNetwork(
	{{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}},
	{1,2,3,4}, {{{5,6},{6,7}}});
    edgePairs := {
	{{1,5},{8,4}}, {{1,9},{7,3}}, {{1,11},{6,2}}, {{4,8},{12,3}},
	{{4,15},{14,2}}, {{4,17},{13,1}}, {{3,16},{18,2}}, {{3,21},{20,1}}
	};
    endpoints := {8,7,6,12,14,13,18,20};
    scan(r-1, j -> N = addNetworkEdge(N,edgePairs#j,endpoints#j));
    N
    );

networkBuilder = buildSpiral;
family = "spiral";
leafPatternDict = leafPatternDict4L;

<< "" << endl;
<< "-------------------------------------------------------------------------------" << endl;
<< "----------------------- studying the spiral networks --------------------------" << endl;
<< "-*-----------------------------------------------------------------------------" << endl;
<< "-- starting with level-1 spiral network:" << endl;
<< peek buildSpiral 1 << endl;
<< "-*------------------- adding new retiuclation events --------------------------" << endl;
