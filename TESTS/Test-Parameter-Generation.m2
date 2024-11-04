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
-- Start M2 buffer in one directory above
needs "Parametrization-Generation.m2"
needs "TESTS/Test-Parameter-Generation.m2"
-- Sanity checks
peek N4Leaves
peek M4Leaves
--Compute parametrizations
computeParametrization(N4Leaves,M4Leaves,false) -- parametrization without the Fourier coordinates
computeParametrization(N4Leaves,M4Leaves,true) -- parametrization with the Fourier coordinates
