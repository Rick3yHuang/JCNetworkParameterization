-- Inputs:
---------------------Run this for a test for a level-2 3-leaf network-----------------
-- An example of a three-leaf network
leaves3LL2 = {1,2,3}
EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
network3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)

end

restart
changeDirectory("../../../src/")
currentDirectory() -- should be gitrepo/JCNetworkParameterization/src/
needsPackage "JCNetworkParameterization"
-- JC Model for three leaves
needs "../analysis/proof-of-concept-examples/3-leaf-networks/3-leaf-model-init.m2"
needs "../analysis/proof-of-concept-examples/3-leaf-networks/3-leaf-level-2-network-parameterization-generation.m2"
-- Sanity checks
peek network3LL2
peek fourierIndices3L
netList computeParameterization(network3LL2,fourierIndices3L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(network3LL2,fourierIndices3L) -- parametrization with the Fourier coordinates
