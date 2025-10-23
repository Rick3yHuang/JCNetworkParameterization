-- Inputs:
---------------------Run this for a test for a level-2 3-leaf network-----------------
-- JC Model for three leaves
y3L = hashTable{A => 0, C => 1, G => 2, T => 3}
L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)}
M3Leaves = getModel(L3L,y3L)
-- An example of a three-leaf network
leaves3L = {1,2,3}
EPList3L = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
EPListSorted3L = sort apply(#EPList3L, j -> sort EPList3L#j);
reticulationPairList3L = {{{4,6},{5,6}},{{6,7},{7,8}}};
N3Leaves = getNetwork(EPListSorted3L,leaves3L,reticulationPairList3L,2)
end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/3-Leaf-Level-2-Parameter-Generation.m2"
-- Sanity checks
peek N3Leaves
peek M3Leaves
netList computeParameterization(N3Leaves,M3Leaves,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N3Leaves,M3Leaves) -- parametrization with the Fourier coordinates
