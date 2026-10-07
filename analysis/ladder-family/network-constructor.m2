buildLadder = method();
buildLadder ZZ := r -> (
    if r < 1 then error "r must be at least 1";
    if r > 8 then (
	<< "-- Please specify reticulation events for r > 8 in ladder-family/network-constructor.m2" << endl;
	<< "-- and rerun the script." << endl;
	error "Only have information for ladder networks with 1 to 8 reticulations";
	);
    N := getNetwork(
	{{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}},
	{1,2,3,4}, {{{5,6},{6,7}}});
    edgePairs := {
	{{1,5},{2,6}},{{1,9},{2,10}},{{1,11},{2,12}},{{1,13},{2,14}},
        {{1,15},{2,16}},{{1,17},{2,18}},{{1,19},{2,20}},{{1,21},{2,22}}
    };
endpoints := {6,10,12,14,16,18,20,22};
scan(r-1, j -> N = addNetworkEdge(N,edgePairs#j,endpoints#j));
N
);

networkBuilder = buildLadder;
family = "ladder";
leafPatternDict = leafPatternDict4L;

<< "" << endl;
<< "-------------------------------------------------------------------------------" << endl;
<< "----------------------- studying the ladder networks --------------------------" << endl;
<< "-*-----------------------------------------------------------------------------" << endl;
<< "-- starting with a ladder network with one reticulation:" << endl;
<< peek buildLadder 1 << endl;
<< "-*------------------- adding new reticulation events ---------------------------" << endl;
