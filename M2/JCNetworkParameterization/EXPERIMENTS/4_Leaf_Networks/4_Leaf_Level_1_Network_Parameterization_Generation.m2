-- Inputs:
---------------------Run this for a test for a level-1 4-leaf network-----------------
-- JC Model for four leaves
needs "JCNetworkParameterization/EXPERIMENTS/4_Leaf_Networks/4_Leaf_Model_Init.m2"
-- An example of a four-leaf network
leaves4LL1 = {1,2,3,4}
EPList4LL1 = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulationPairList4LL1 = {{{6,7},{7,8}}};
N4LL1 = getNetwork(EPList4LL1,leaves4LL1,reticulationPairList4LL1)
end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/4_Leaf_Networks/4_Leaf_Level_1_Network_Parameterization_Generation.m2"
-- Sanity checks
peek N4LL1
peek M4L
netList computeParameterization(N4LL1,M4L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N4LL1,M4L) -- parametrization with the Fourier coordinates
