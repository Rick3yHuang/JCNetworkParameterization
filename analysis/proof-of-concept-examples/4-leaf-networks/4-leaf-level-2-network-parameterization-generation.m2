-- Inputs:
---------------------Run this for a test for a level-2 4-leaf network-----------------
-- An example of a four-leaf network
leaves4LL2 = {1,2,3,4}
edgePairList4LL2 = {{1,8},{7,8},{8,9},{6,7},{5,6},{5,9},{6,10},{5,10},{4,6},{2,5},{3,10}};
reticulationPairList4LL2 = {{{6,7},{5,6}},{{5,10},{6,10}}};
network4LL2 = getNetwork(edgePairList4LL2,leaves4LL2,reticulationPairList4LL2)
end

restart -- start from here
needsPackage "JCNetworkParameterization"
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-model-init.m2"
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-level-2-network-parameterization-generation.m2"
-- Sanity checks
peek network4LL2
peek fourierIndices4L
netList computeParameterization(network4LL2,fourierIndices4L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(network4LL2,fourierIndices4L) -- parametrization with the Fourier coordinates
