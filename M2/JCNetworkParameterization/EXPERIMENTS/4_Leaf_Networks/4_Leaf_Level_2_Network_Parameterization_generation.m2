-- Inputs:
---------------------Run this for a test for a level-1 4-leaf network-----------------
-- JC Model for four leaves
needs "JCNetworkParameterization/EXPERIMENTS/4_Leaf_Networks/4_Leaf_Model_Init.m2"
-- An example of a four-leaf network
leaves4LL2 = {1,2,3,4}
EPList4LL2 = {{1,8},{7,8},{8,9},{6,7},{5,6},{5,9},{6,10},{5,10},{4,6},{2,5},{3,10}};
reticulationPairList4LL2 = {{{6,7},{5,6}},{{5,10},{6,10}}};
N4LL2 = getNetwork(EPList4LL2,leaves4LL2,reticulationPairList4LL2)
end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/4_Leaf_Networks/4_Leaf_Level_2_Network_Parameterization_Generation.m2"
-- Sanity checks
peek N4LL2
peek M4L
netList computeParameterization(N4LL2,M4L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N4LL2,M4L) -- parametrization with the Fourier coordinates
