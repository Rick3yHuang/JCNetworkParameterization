buildZigZagLadder = method();
buildZigZagLadder ZZ := r -> (
    if r < 1 then error "r must be at least 1";
    if r > 8 then (
	<< "-- Please specify reticulation events for r > 8 in zig-zag-ladder-family/network-constructor.m2" << endl;
	<< "-- and rerun the script." << endl;
	error "Only have information of level-1 to 8 zig-zag ladder networks";
	);
    N := getNetwork(
	{{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}},
	{1,2,3,4}, {{{5,6},{6,7}}});
    edgePairs := {
	{{1,5},{2,6}},{{1,9},{2,10}},{{1,11},{2,12}},{{1,13},{2,14}},
        {{1,15},{2,16}},{{1,17},{2,18}},{{1,19},{2,20}},{{1,21},{2,22}}
    };
endpoints := {5,10,11,14,15,18,19,22};
scan(r-1, j -> N = addNetworkEdge(N,edgePairs#j,endpoints#j));
N
);

networkBuilder = buildZigZagLadder;
family = "zig-zag ladder";
leafPatternDict = leafPatternDict4L;

<< "" << endl;
<< "-------------------------------------------------------------------------------" << endl;
<< "------------------- studying the zig-zag ladder networks ----------------------" << endl;
<< "-*-----------------------------------------------------------------------------" << endl;
<< "-- starting with level-1 zig-zag ladder network:" << endl;
<< peek buildLadder 1 << endl;
<< "-*------------------- adding new reticulation events ---------------------------" << endl;
