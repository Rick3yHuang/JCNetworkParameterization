-- Inputs:
---------------------Run this for a test for a Half-Ziggurat network-----------------
-- JC Model for four leaves
needs "JCNetworkParameterization/EXPERIMENTS/Proof_Of_Concept_Examples/4_Leaf_Networks/4_Leaf_Model_Init.m2"
-- An example of a four-leaf network
leavesHalfZiggurat = {1,2,3,4}
EPListToStart = {{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}};
reticulationPairListToStart = {{{5,6},{6,7}}};
NToStart = getNetwork(EPListToStart,leavesHalfZiggurat,reticulationPairListToStart) -- build base network
finalNumOfReticulationPairs = 7; -- we'll build networks up to 7 reticuations
EPListToDivide = {{{3,7},{8,4}},{{1,5},{10,4}},{{3,9},{12,4}},{{1,11},{14,4}},{{3,13},{16,4}},{{1,15},{18,4}}}; -- see figure
verticesInNewReticulations = {8,10,12,14,16,18}; -- sources of new reticulation edges
currentNetwork = NToStart;
i = 0
networkOfInterestIndex = 0 -- indicates which network to save, e.g., if =3, then save the network with 5 reticulations
<< "-*" << endl;
<< "Reticuation Pairs: " << getReticulationEdges currentNetwork << endl;
<< "Number of Reticulation Pairs: " << #(getReticulationEdges currentNetwork) << endl; --<< ", dimension of the network: " << rank kernel jacobian matrix{computeParameterization(currentNetwork,M4L,includeQs => false)} << endl;
<< "*-" << endl;
while i < finalNumOfReticulationPairs-1 do (
    currentNetwork = addNetworkEdge(currentNetwork,EPListToDivide_i,verticesInNewReticulations_i);
    << "-*" << endl;
    << "Reticuation Pairs: " << getReticulationEdges currentNetwork << endl;
    << "Number of Reticulation Pairs: " << #(getReticulationEdges currentNetwork) << endl; --<< ", dimension of the network: " << rank kernel jacobian matrix{computeParameterization(currentNetwork,M4L,includeQs => false)} << endl;
    << "*-" << endl;
    if i == networkOfInterestIndex then networkOfInterest = currentNetwork;
    i += 1;
    )
end -- the output is networkOfInterest, a ziggurat with networkOfInterestIndex+2 reticulation

restart -- start here
needsPackage "JCNetworkParameterization"
needsPackage "MultigradedImplicitization"
needs "JCNetworkParameterization/EXPERIMENTS/Paper_Examples/Half_Ziggurat.m2"
-- Find parameterization
peek networkOfInterest
peek M4L
p = toList computeParameterization(networkOfInterest,M4L,includeQs => false); -- parametrization without the Fourier coordinates
-- find phi
paramR = ring p_0 -- this returns the ring that p_0 lives in
fourierCoordinates := toList apply((getNucleotideSequence M4L),j-> q_(toSequence apply(#j, k -> (getTransformTable M4L)#(j#k)))); -- buids the correctly-named fourier coordinate variables
qR = QQ[fourierCoordinates]
phi = map(paramR,qR,p)
-- find generators up to maxDegree
maxDegree = 5
G = componentsOfKernel(maxDegree,phi)
I = ideal flatten values G
dim I
isPrime I
netList flatten entries gens I

