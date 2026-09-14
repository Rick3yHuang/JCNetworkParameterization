-- Computes parameterization, dimesnion, and ideals for networks in the nonreticulate half-ziggurat family.


-- JC Model for four leaves
needs "../analysis/proof-of-concept-examples/4-leaf-networks/4-leaf-model-init.m2"

---------------------Build a family of networks-----------------

-- First, build initial network ('base case' = 4-sunlet)
leafSet = {1,2,3,4}
initialEdges = {{1,5},{2,6},{3,7},{4,8},{5,6},{5,8},{6,7},{7,8}};
initialReticulations = {{{5,6},{6,7}}};
initialNetwork = getNetwork(initialEdges,leafSet,initialReticulations) -- build base network
peek initialNetwork


-- define pairs of edges (source edge, target edge) for the reticulations we
-- will add, as well as a list of 'existing source nodes' for each of the
-- added reticulations. The specified values will produce the family matching
-- the figure in the paper
STpairs = {{{3,7},{8,4}},{{1,5},{10,4}},{{3,9},{12,4}},{{1,11},{14,4}},{{3,13},{16,4}},{{1,15},{18,4}}};
existingSourceNodes = {8,10,12,14,16,18}; -- sources of new reticulation edges

network = initialNetwork;
maxR = 7; -- we'll build networks up to 7 reticulations
for i from 0 to maxR-1 do (
    -- compute and print dimension for network
    << "-*" << endl;
    << "Network N_" << i << ":" << endl; -- name of network in paper
    << peek network << endl;
    networkParam = computeParameterization(network,M4L,includeQs => false);
    networkDimension = computeDimensionNumerically networkParam;
    << "Dimension of affine network variety             : " << networkDimension << endl;
    << "*-" << endl;
    -- save network if it has the correct specified number of reticulations
    if i == nr - 1 then myNetwork = network;
    -- update network by adding a reticulation
    network = addNetworkEdge(network,STpairs_i,existingSourceNodes_i);
    )
end -- the output is network, a ziggurat with networkIndex+2 reticulation


restart -- start here. Start Macualay2 from this directory JCNetworkParameterization/analysis/

-- First load packages
changeDirectory("../src/")
currentDirectory() -- should be gitrepo/JCNetworkParameterization/src/
needsPackage "JCNetworkParameterization"
needsPackage "MultigradedImplicitization"

-- Next, compute the dimension numerically for each network in the network
-- family up to 7 reticulations. We'll save one network, called myNetwork,
-- which is chosen by the user.
nr = 3 -- number of reticulations on myNetwork (CHOOSE THIS)
needs "../analysis/half-ziggurat.m2"

-- Find parameterization
peek myNetwork
peek M4L
p = toList computeParameterization(myNetwork,M4L,includeQs => false); -- parametrization without the Fourier coordinates

-- find phi

paramRing = ring p_0 -- this returns the ring that p_0 lives in
fourierCoordinates = toList apply((getNucleotideSequence M4L),j-> q_(toSequence apply(#j, k -> (getTransformTable M4L)#(j#k)))); -- builds the correctly-named fourier coordinate variables
qRing = QQ[fourierCoordinates]

phi = map(paramRing,qRing,p)

-- find generators up to maxDegree
maxDegree = 3
G = componentsOfKernel(maxDegree,phi)
I = ideal flatten values G
dim I
isPrime I
netList flatten entries gens I
