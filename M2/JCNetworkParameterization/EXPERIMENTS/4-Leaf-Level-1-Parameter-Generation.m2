-- Inputs:
---------------------Run this for a test for a level-1 4-leaf network-----------------
-- JC Model for four leaves
y4L = hashTable{A => 0, C => 1, G => 2, T => 3}
L4L = {(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),
     (C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
M4Leaves = getModel(L4L,y4L)
-- An example of a three-leaf network
leaves4L = {1,2,3,4}
EPList4L = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
EPListSorted4L = sort apply(#EPList4L, j -> sort EPList4L#j);
reticulationPairList4L = {{{6,7},{7,8}}};
N4Leaves = getNetwork(EPListSorted4L,leaves4L,reticulationPairList4L,1)
end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/4-Leaf-Level-1-Parameter-Generation.m2"
-- Sanity checks
peek N4Leaves
peek M4Leaves
netList computeParameterization(N4Leaves,M4Leaves,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N4Leaves,M4Leaves) -- parametrization with the Fourier coordinates
