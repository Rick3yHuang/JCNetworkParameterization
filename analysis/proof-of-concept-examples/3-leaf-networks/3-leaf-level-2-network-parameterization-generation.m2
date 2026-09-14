-- Inputs:
---------------------Run this for a test for a level-2 3-leaf network-----------------
-- An example of a three-leaf network
leaves3LL2 = {1,2,3}
EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)

end

restart
needsPackage "JCNetworkParameterization"
-- JC Model for three leaves
needs "../analysis/proof-of-concept-examples/3-leaf-networks/3-leaf-model-init.m2"
needs "../analysis/proof-of-concept-examples/3-leaf-networks/3-leaf-level-2-network-parameterization-generation.m2"
-- Sanity checks
peek N3LL2
peek M3L
netList computeParameterization(N3LL2,M3L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N3LL2,M3L) -- parametrization with the Fourier coordinates
