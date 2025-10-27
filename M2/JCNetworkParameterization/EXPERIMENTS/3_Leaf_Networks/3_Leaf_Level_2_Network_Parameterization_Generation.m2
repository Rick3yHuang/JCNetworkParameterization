-- Inputs:
---------------------Run this for a test for a level-2 3-leaf network-----------------
-- JC Model for three leaves
needs "JCNetworkParameterization/EXPERIMENTS/3_Leaf_Networks/3_Leaf_Model_Init.m2"
-- An example of a three-leaf network
leaves3LL2 = {1,2,3}
EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)

end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/3_Leaf_Networks/3_Leaf_Level_2_Network_Parameterization_Generation.m2"
-- Sanity checks
peek N3LL2
peek M3L
netList computeParameterization(N3LL2,M3L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N3LL2,M3L) -- parametrization with the Fourier coordinates
