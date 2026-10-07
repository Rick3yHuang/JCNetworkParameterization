returnGeneratorsOfStabilizedIdeal = method();
returnGeneratorsOfStabilizedIdeal (List,ZZ,ZZ,LeafPatternDict) := (parameterization,reticulationsStabilized,maxDegree,leafPatternDict) -> (
    paramRing := ring first parameterization;
    fourierCoordinates := toList apply((getLeafPatternClasses leafPatternDict),j-> q_(toSequence apply(#j, k -> (getNumericLabeling leafPatternDict)#(j#k)))); -- builds the correctly-named fourier coordinate variables
    qRing := QQ[fourierCoordinates];
    phi := map(paramRing,qRing,parameterization);

    << "-*----------------------- componentsOfKernel outputs --------------------------" << endl;
    G := componentsOfKernel(maxDegree,phi);
    << "-*-----------------------------------------------------------------------------" << endl;
    I := ideal flatten values G;
    if not isPrime I then << "-- Warning: the ideal is not prime. The generators returned may not be minimal." << endl;
    << "-* The generators of the stabilized ideal up to degree " << maxDegree << " are: " << endl;
    << netList flatten entries gens I << endl;
    << "-*------------------ Exiting the " << family << " network example ----------------------- " << endl;
    )
