dir = currentFileDirectory
needsPackage("JCNetworkParameterization",FileName => dir | "../src/JCNetworkParameterization.m2");
needsPackage "MultigradedImplicitization";
-- Add every problem subdirectory to the search path
path = {
    dir | "one-sided-terrace-family/",
    dir | "spiral-family/",
    dir | "ladder-family/",
    dir | "zig-zag-ladder-family/"
    } | path

needs "setup.m2"
needs "stabilize-dim.m2"
needs "find-generators-of-ideal-stabilized.m2"

networkFamilies = {
    -- (constructorFile, maxLevel, expectedDimStabilized, generatorMaxDegree)
    ("one-sided-terrace-family/network-constructor.m2",   6,  12,  3),
    ("spiral-family/network-constructor.m2",		  7,  15,  3),
    ("ladder-family/network-constructor.m2",		  5,  9,   2),
    ("zig-zag-ladder-family/network-constructor.m2",	  5,  11,  3)
    }

<< "" << endl;
setRandomSeed 20260930;

for data in networkFamilies do (
    (familyFile, maxLevel, expectedDimStabilized, generatorMaxDegree) = data;
    needs familyFile;
    dimList = {};
    elapsedTime scan(maxLevel, r -> (
	    N = networkBuilder (r+1);
	    parameterization = computeParameterization(N,leafPatternDict4L,includeQs => false);
	    estimatedDimension = computeDimensionNumerically parameterization;
	    dimList = append(dimList, estimatedDimension);
	    << "-- Level-" << toString (r+1) << " "<< family << " network: estimated dimension = " << toString estimatedDimension << endl
	    )
	);
    levelStabilized = stabilizationIndex dimList;
    dimStabilized = if levelStabilized > 0 then dimList#(levelStabilized-1) else 0;
    << "-------------------------------------------------------------------------------" << endl;
    if levelStabilized > 0 then (
	<< "-- The estimated dimension stabilizes at level " << toString levelStabilized << " with dimension " << toString dimStabilized<< endl;
	if dimStabilized == expectedDimStabilized then
	<< "-- expected dimension stabilization checked OK." << endl
	else(
	<< "-- Warning: expected dimension stabilization is " << toString expectedDimStabilized << endl;
	<< "--          but the estimated dimension stabilization is " << toString dimStabilized << endl;);
	NStabilized = networkBuilder levelStabilized;
	parameterizationStabilized = computeParameterization(NStabilized,leafPatternDict,includeQs => false);
	returnGeneratorsOfStabilizedIdeal(toList parameterizationStabilized,levelStabilized,generatorMaxDegree,leafPatternDict);
	)
    else << "-- The estimated dimension does not stabilize in the range of levels considered." << endl;
    )
<< "-------------------------- All examples are done! -----------------------------" << endl;
end

restart
needs "run-all.m2"
