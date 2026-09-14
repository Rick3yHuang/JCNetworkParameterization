-- Inputs:
---------------------Run this for a test for a level-1 4-leaf network-----------------
-- An example of a four-leaf network
leaves4LL1 = {1,2,3,4}
edgePairList4LL1 = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulationPairList4LL1 = {{{6,7},{7,8}}};
network4LL1 = getNetwork(edgePairList4LL1,leaves4LL1,reticulationPairList4LL1)
end

restart
needsPackage "JCNetworkParameterization"
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-model-init.m2"
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-level-1-network-parameterization-generation.m2"
-- Sanity checks
peek network4LL1
peek fourierIndices4L
netList computeParameterization(network4LL1,fourierIndices4L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(network4LL1,fourierIndices4L) -- parametrization with the Fourier coordinates

