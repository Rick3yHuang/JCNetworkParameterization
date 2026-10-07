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
    -- (constructorFile, maxReticulations, generatorMaxDegree)
    ("one-sided-terrace-family/network-constructor.m2",   6,  3),
    ("spiral-family/network-constructor.m2",		  7,  3),
    ("ladder-family/network-constructor.m2",		  5,  2),
    ("zig-zag-ladder-family/network-constructor.m2",	  5,  3)
    }

<< "" << endl;
setRandomSeed 20260930;

for data in networkFamilies do (
    (familyFile, maxReticulations, generatorMaxDegree) = data;
    needs familyFile;
    dimList = {};
    elapsedTime scan(maxReticulations, r -> (
	    N = networkBuilder (r+1);
	    parameterization = computeParameterization(N,leafPatternDict4L,includeQs => false);
	    estimatedDimension = computeDimensionNumerically parameterization;
	    dimList = append(dimList, estimatedDimension);
	    << "-- " << family << " network with " << toString (r+1) << " reticulations: estimated dimension = " << toString estimatedDimension << endl
	    )
	);
    reticulationsStabilized = stabilizationIndex dimList;
    dimStabilized = if reticulationsStabilized > 0 then dimList#(reticulationsStabilized-1) else 0;
    << "-------------------------------------------------------------------------------" << endl;
    if reticulationsStabilized > 0 then (
	<< "-- The estimated dimension stabilizes at " << toString reticulationsStabilized << " reticulations with dimension " << toString dimStabilized<< endl;
	NStabilized = networkBuilder reticulationsStabilized;
	parameterizationStabilized = computeParameterization(NStabilized,leafPatternDict,includeQs => false);
	returnGeneratorsOfStabilizedIdeal(toList parameterizationStabilized,reticulationsStabilized,generatorMaxDegree,leafPatternDict);
	)
    else << "-- The estimated dimension does not stabilize in the range of reticulation counts considered." << endl;
    )
<< "-------------------------- All examples are done! -----------------------------" << endl;
end

restart
needs "run-all.m2"
