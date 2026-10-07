-*
doc ///
Key
Headline
Usage
Inputs
Outputs
Consequences
  Item
Description
  Text
  Example
  CannedExample
  Code
  Pre
ExampleFiles
Contributors
References
Caveat
SeeAlso
///
*-

undocumented {
    }

doc ///
  Key
   JCNetworkParameterization
  Headline
     A Macaulay2 package to work with Phylogenetics Identifiability.
  Description
   Text
    {\em JCNetworkParameterization} is a package that can find the parameterization of a given network
--  Caveat
  Subnodes
    addNetworkEdge
    computeParameterization
    computeDimensionNumerically
    Network
    LeafPatternDict
    getLeafPatternDict
    getLeafPatternClasses
    getNumericLabeling
    getGroupLabeling
    getNetwork
    getReticulationEdges
    getEdges
///

--------------------------------------------------
-------------------- Data Types-------------------
--------------------------------------------------

doc /// 
  Key
    Network
  Headline
    A general datatype for a network
  Description
    Text

  SeeAlso
    
///

doc /// 
  Key
    LeafPatternDict
  Headline
    A general datatype for a set of leaf pattern equivalence classes and dictionaries of group labeling
  Description
    Text

  SeeAlso
    
///

--------------------------------------------------
--------------Functions and Commands--------------
--------------------------------------------------
doc ///
  Key
   computeParameterization
   (computeParameterization,Network,LeafPatternDict)
   [computeParameterization,includeQs]
  Headline
    Compute the parameterization of a given network under a given model
  Usage
    computeParameterization(N,leafPatternDict)
  Inputs
    N: Network
       a network indicating the edges, leaves, reticulation edges, and number of reticulations of the network.
    leafPatternDict: LeafPatternDict
       a LeafPatternDict data type including the leaf pattern classes and group labeling the network.
    includeQs => Boolean
       a boolean value indicating whether the Fourier coordinates should be included in the parameterization
  Outputs
    parameterization: List
       a list of polynomials from the parameterization
  Description
   Text
     Let N3L2R be a 3-leaf network with two reticulations and M3L be a Jukes-Canter phylogenetic model. This function computes the
     parameterization of N3L2R under the model M3L. The output is a list of polynomials representing the parameterization.
   Example
     leafPattern3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
     numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3}
     groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}}
     leafPatternDict3L= getLeafPatternDict(leafPattern3L,numericLabeling3L,groupLabeling3L);
     leaves3L2R = {1,2,3};
     edgePairList3L2R = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
     reticulationPairList3L2R = {{{4,6},{5,6}},{{6,7},{7,8}}};
     network3L2R = getNetwork(edgePairList3L2R,leaves3L2R,reticulationPairList3L2R)
     netList computeParameterization(network3L2R,leafPatternDict3L,includeQs => false) -- parametrization without the Fourier coordinates
     netList computeParameterization(network3L2R,leafPatternDict3L)
  SeeAlso
    (getNetwork,List,List,List)
    (getLeafPatternDict,List,HashTable,HashTable)
///

doc /// 
  Key
    getLeafPatternDict
    (getLeafPatternDict,List,HashTable,HashTable)
  Headline
    A constructor method for the LeafPatternDict data type
  Usage
    getLeafPatternDict(leafPatternClasses,numericLabeling,groupLabeling)
  Inputs
    leafPatternClasses: List
       a list of leaf pattern classes for the model
    numericLabeling: HashTable
       a hash table indicating the representatives and the numeric labeling for a network
    groupLabeling: HashTable
       a hash table indicating the representatives and the group labeling for a network
  Outputs
    leafPatternDict: LeafPatternDict
       a LeafPatternDict data type including the leaf pattern classes and group labeling for the model
  Description
    Text
      The following example constructs a LeafPatternDict data type for a Jukes-Cantor model on a three-leaf network.
    Example
      leafPatternClasses3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
      numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3};
      groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
      leafPatternDict3L = getLeafPatternDict(leafPatternClasses3L,numericLabeling3L,groupLabeling3L)
///


doc /// 
  Key
    getLeafPatternClasses
    (getLeafPatternClasses,LeafPatternDict)
  Headline
    An accessor method for the leaf pattern classes of a LeafPatternDict data type
  Usage
    getLeafPatternClasses(LeafPatternDict)
  Inputs
    leafPatternDict: LeafPatternDict
       a LeafPatternDict data type including the leaf pattern classes and group labeling for the model
  Outputs
    leafPatternClasses: List
       a list of leaf pattern classes for the model
  Description
    Text
       This method retrieves the leaf pattern classes as a vertical list from a given LeafPatternDict data type.
    Example
       leafPatternClasses3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
       numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3};
       groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
       leafPatternDict3L = getLeafPatternDict(leafPatternClasses3L,numericLabeling3L,groupLabeling3L)
       getLeafPatternClasses leafPatternDict3L
  SeeAlso
    (getLeafPatternDict,List,HashTable,HashTable)
///

doc /// 
  Key
	getNumericLabeling
	(getNumericLabeling,LeafPatternDict)
  Headline
	An accessor method for the numeric labeling of a LeafPatternDict data type
  Usage
	getNumericLabeling(LeafPatternDict)
  Inputs
	leafPatternDict: LeafPatternDict
	   a LeafPatternDict data type including the leaf pattern classes and group labeling for the model
  Outputs
	numericLabeling: HashTable
	   a hash table indicating the representatives and the numeric labeling for the network
  Description
	Text
	   This method retrieves the numeric labeling as a hash table from a given LeafPatternDict data type.
	Example
	   leafPatternClasses3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
	   numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3};
	   groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
	   leafPatternDict3L = getLeafPatternDict(leafPatternClasses3L,numericLabeling3L,groupLabeling3L)
	   getNumericLabeling leafPatternDict3L
  SeeAlso
	(getLeafPatternDict,List,HashTable,HashTable)
///	

doc ///
  Key
    getGroupLabeling
    (getGroupLabeling,LeafPatternDict)
  Headline
    An accessor method for the group labeling of a LeafPatternDict data type
  Usage
    getGroupLabeling(LeafPatternDict)
  Inputs
    leafPatternDict: LeafPatternDict
       a LeafPatternDict data type including the leaf pattern classes and group labeling for the model
  Outputs
    groupLabeling: HashTable
       a hash table indicating the representatives and the group labeling for the network
  Description
    Text
       This method retrieves the group labeling as a hash table from a given LeafPatternDict data type.
    Example
       leafPatternClasses3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
       numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3};
       groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
       leafPatternDict3L = getLeafPatternDict(leafPatternClasses3L,numericLabeling3L,groupLabeling3L)
       getGroupLabeling leafPatternDict3L
  SeeAlso
    (getLeafPatternDict,List,HashTable,HashTable)
///

doc /// 
  Key
    getNetwork
    (getNetwork,List,List,List)
  Headline
    A constructor method for the Network data type
  Usage
    getNetwork(EPListSorted,leaves,reticulationEdges)
  Inputs
    EPListSorted: List
       a list of edges in the network, where each edge is represented as a list of two vertices
    leaves: List
       a list of leaves in the network
    reticulationEdges: List
       a list of reticulation edges in the network, where each reticulation edge is represented as a list of two vertices
  Outputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and number of reticulations of the network
  Description
    Text
      The following example constructs a Network data type for a 3-leaf network with two reticulations.
    Example
      leaves3L2R = {1,2,3};
      EPList3L2R = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3L2R = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3L2R = getNetwork(EPList3L2R,leaves3L2R,reticulationPairList3L2R)
///

doc /// 
  Key
    getReticulationEdges
    (getReticulationEdges,Network)
  Headline
    An accessor method for the reticulation edges of a Network data type
  Usage
    getReticulationEdges(Network)
  Inputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and number of reticulations
  Outputs
    reticulationEdges: List
       a list of reticulation edges in the network, where each reticulation edge is represented as a list of two vertices
  Description
    Text
      This method retrieves the reticulation edges as a vertical list from a given Network data type.
    Example
      leaves3L2R = {1,2,3};
      EPList3L2R = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3L2R = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3L2R = getNetwork(EPList3L2R,leaves3L2R,reticulationPairList3L2R);
      getReticulationEdges N3L2R
  SeeAlso
    (getNetwork,List,List,List)
///

doc /// 
  Key
    getEdges
    (getEdges,Network)
  Headline
    An accessor method for the edges of a Network data type
  Usage
    getEdges(Network)
  Inputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and number of reticulations
  Outputs
    edges: List
       a list of edges in the network, where each edge is represented as a list of two
  Description
    Text
      This method retrieves the edges as a vertical list from a given Network data type.
    Example
      leaves3L2R = {1,2,3};
      EPList3L2R = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3L2R = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3L2R = getNetwork(EPList3L2R,leaves3L2R,reticulationPairList3L2R);
      getEdges N3L2R
  SeeAlso
    (getNetwork,List,List,List)
///

doc /// 
  Key
    addNetworkEdge
    (addNetworkEdge,Network,List,ZZ)
    (addNetworkEdge,Network,List,List)
  Headline
    Add an edge by dividing two existing edges and add a new pair of reticulation edges to a Network data type.
  Usage
    addNetworkEdge(N,edgesToDivide,vertexInNewReticulation)
    addNetworkEdge(N,edgesToDivideList,vertexInNewReticulationList)
  Inputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and number of reticulations of the network
    edgesToDivide: List
       a list of two edges to divide when adding a new edge
    vertexInNewReticulation: ZZ
       an integer representing the vertex in the new reticulation edge. This is the source vertex for one of
       the reticulation edges
    edgesToDivideList: List
       a list of lists of two edges to divide when adding new edges
    vertexInNewReticulationList: List
       a list of integers representing the vertices in the new reticulation edges
  Outputs
    NNew: Network
       a Network data type including the updated sorted edges, leaves, reticulation edges, and number of reticulations of the network
  Description
    Text
      The following example adds a new reticulation edge to a given Network data type by dividing two existing edges.
    Example
      edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
      reticulations = {{{6,7},{7,8}}};
      leaves = {1,2,3,4};
      exampleNetwork = getNetwork(edges,leaves,reticulations);
      exampleNetwork2 = addNetworkEdge(exampleNetwork,{{1,8},{7,2}},7);
      peek exampleNetwork => peek oo
    Text
      The following example adds two new reticulation edges to a given Network data type by dividing four existing edges.
    Example
      edges = {{1,8},{2,7},{3,6},{4,5},{5,6},{6,7},{7,8},{5,8}};
      reticulations = {{{6,7},{7,8}}};
      leaves = {1,2,3,4};
      exampleNetwork = getNetwork(edges,leaves,reticulations);
      exampleNetwork2 = addNetworkEdge(exampleNetwork,{{{1,8},{7,2}},{{3,6},{4,5}}},{7,3});
      peek exampleNetwork => peek oo
  SeeAlso
    Network
    (getNetwork,List,List,List)
///

doc /// 
  Key
    computeDimensionNumerically
    (computeDimensionNumerically,List)
  Headline
    Compute the dimension of a given parameterization numerically
  Usage
    computeDimensionNumerically(parameterization)
  Inputs
    parameterization: List
       a list of polynomials from the parameterization without the Fourier coordinates
  Outputs
    dimension: ZZ
       an integer representing the dimension of the given parameterization
  Description
    Text
      Given a three-leaf network with two reticulations N3L2R and a Jukes-Cantor model M3L, the following example
      computes the parameterization of N3L2R under M3L without the Fourier coordinates and then
      computes the dimension of the parameterization numerically.
    Example
      leafPattern3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
      numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3};
      groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
      leafPatternDict3L = getLeafPatternDict(leafPattern3L,numericLabeling3L,groupLabeling3L);
      leaves3L2R = {1,2,3};
      edgePairList3L2R = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3L2R = {{{4,6},{5,6}},{{6,7},{7,8}}};
      network3L2R = getNetwork(edgePairList3L2R,leaves3L2R,reticulationPairList3L2R)
      paramerterization = computeParameterization(network3L2R,leafPatternDict3L,includeQs => false) -- parametrization without the Fourier coordinates
      computeDimensionNumerically paramerterization
  SeeAlso
    (computeParameterization,Network,LeafPatternDict)
///

--------------------------------------------------
--------------------Symbols-----------------------
--------------------------------------------------
doc /// 
  Key
    includeQs
  Headline
    An optional input for computeParameterization
  Description
    Text
      A boolean value indicating whether the Fourier coordinates should be included in the parameterization.
  SeeAlso
///
