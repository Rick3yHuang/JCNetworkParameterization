-- Inputs:
---------------------Run this for a test for a Half-Ziggurat network-----------------
-- JC Model for four leaves
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-model-init.m2"
-- An example of a four-leaf network
leavesHalfZiggurat = {1,2,3,4}
EPListToStart = {{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}};
reticulationPairListToStart = {{{5,6},{6,7}}};
baseNetwork = getNetwork(EPListToStart,leavesHalfZiggurat,reticulationPairListToStart) -- build base network
peek baseNetwork

finalNumOfReticulationPairs = 2; -- we'll build networks up to 7 reticuations
EPListToDivide = {{{3,7},{8,4}},{{1,5},{10,4}},{{3,9},{12,4}},{{1,11},{14,4}},{{3,13},{16,4}},{{1,15},{18,4}}}; -- see figure
verticesInNewReticulations = {8,10,12,14,16,18}; -- sources of new reticulation edges
currentNetwork = baseNetwork;
i = 0
networkOfInterest = baseNetwork;
networkOfInterestReticulationNum = 1 -- indicates which network to save (should be a number >= 1)
<< "-*" << endl;
<< "Reticuation Pairs: " << getReticulationEdges currentNetwork << endl;
<< "Number of Reticulation Pairs: " << #(getReticulationEdges currentNetwork) << ", dimension of the network: " << computeDimensionNumerically computeParameterization(currentNetwork,M4L,includeQs => false) << endl;
<< "*-" << endl;
while i < finalNumOfReticulationPairs-1 do (
    currentNetwork = addNetworkEdge(currentNetwork,EPListToDivide_i,verticesInNewReticulations_i);
    << "-*" << endl;
    << "Reticuation Pairs: " << getReticulationEdges currentNetwork << endl;
    << "Number of Reticulation Pairs: " << #(getReticulationEdges currentNetwork) << ", dimension of the network: " << computeDimensionNumerically computeParameterization(currentNetwork,M4L,includeQs => false) << endl;
    << "*-" << endl;
    if i == networkOfInterestReticulationNum-2 then networkOfInterest = currentNetwork;
    i += 1;
    )
end -- the output is networkOfInterest, a ziggurat with networkOfInterestIndex+2 reticulation

restart -- start here
changeDirectory("../src/")
needsPackage "JCNetworkParameterization"
needsPackage "MultigradedImplicitization"
needs "../analysis/half-ziggurat.m2"
-- Find parameterization
peek networkOfInterest
peek M4L
p = toList computeParameterization(networkOfInterest,M4L,includeQs => false); -- parametrization without the Fourier coordinates
-- find phi
paramR = ring p_0 -- this returns the ring that p_0 lives in
fourierCoordinates = toList apply((getNucleotideSequence M4L),j-> q_(toSequence apply(#j, k -> (getTransformTable M4L)#(j#k)))); -- buids the correctly-named fourier coordinate variables
qR = QQ[fourierCoordinates]
phi = map(paramR,qR,p)
-- find generators up to maxDegree
maxDegree = 5
G = componentsOfKernel(maxDegree,phi)
I = ideal flatten values G
dim I
isPrime I
netList flatten entries gens I
