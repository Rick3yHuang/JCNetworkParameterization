-- Inputs:
---------------------Run this for a test for a level-1 4-leaf network-----------------
-- JC Model for four leaves
y4L = hashTable{A => 0, C => 1, G => 2, T => 3}
L4L = {(A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),(C,A,C,A),(C,A,A,C),(C,A,G,T),
     (C,C,A,A),(C,C,C,C),(C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)};
M4L = getModel(L4L,y4L)
-- An example of a three-leaf network
leaves4L = {1,2,3,4}
EPList4L = {{8,1},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
reticulationPairList4L = {{{6,7},{7,8}}};
N4L = getNetwork(EPList4L,leaves4L,reticulationPairList4L)
end

restart
needsPackage "JCNetworkParameterization"
needs "JCNetworkParameterization/EXPERIMENTS/4-Leaf-Level-1-Parameter-Generation.m2"
-- Sanity checks
peek N4L
peek M4L
netList computeParameterization(N4L,M4L,includeQs => false) -- parametrization without the Fourier coordinates
netList computeParameterization(N4L,M4L) -- parametrization with the Fourier coordinates
