buildOneSidedTerrace = method();
buildOneSidedTerrace ZZ := r -> (
    if r < 1 then error "r must be at least 1";
    if r > 7 then (
	<< "-- Please specify reticulation events for r > 7 in one-sided-terrace-family/network-constructor.m2" << endl;
	<< "-- and rerun the script." << endl;
	error "Only have information of level-1 to 7 one-sided terrace networks";
	);
    N := getNetwork(
	{{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}},
	{1,2,3,4}, {{{5,6},{6,7}}});
    edgePairs := {
	{{3,7},{8,4}}, {{1,5},{10,4}}, {{3,9},{12,4}},
	{{1,11},{14,4}}, {{3,13},{16,4}}, {{1,15},{18,4}}
	};
    endpoints := {8,10,12,14,16,18};
    scan(r-1, j -> N = addNetworkEdge(N,edgePairs#j,endpoints#j));
    N
    );

networkBuilder = buildOneSidedTerrace;
family = "one-sided-terrace";
leafPatternDict = leafPatternDict4L;

<< "" << endl;
<< "-------------------------------------------------------------------------------" << endl;
<< "---------------- studying the one-sided terrace networks ----------------------" << endl;
<< "-*-----------------------------------------------------------------------------" << endl;
<< "-- starting with level-1 one-sided terrace network:" << endl;
<< peek buildOneSidedTerrace 1 << endl;
<< "-*------------------- adding new retiuclation events --------------------------" << endl;
