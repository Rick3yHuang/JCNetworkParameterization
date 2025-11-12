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
    Model
    getModel
    getNucleotideSequence
    getTransformTable
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
    Model
  Headline
    A general datatype for a model
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
   (computeParameterization,Network,Model)
   [computeParameterization,includeQs]
  Headline
    Compute the parameterization of a given network under a given model
  Usage
    computeParameterization(N,M)
  Inputs
    N: Network
       a network indicating the edges, leaves, reticulation edges, and level of the network.
    M: Model
       a model including the information about the representatives and converters
    includeQs => Boolean
       a boolean value indicating whether the Fourier coordinates should be included in the parameterization
  Outputs
    parameterization: List
       a list of polynomials from the parameterization
  Description
   Text
     Let N3LL2 be a 3-leaf level-2 network and M3L be a Jukes-Canter phylogenetic model. This function computes the
     parameterization of N3LL2 under the model M3L. The output is a list of polynomials representing the parameterization.
   Example
     y3L = hashTable{A => 0, C => 1, G => 2, T => 3};
     L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
     M3L = getModel(L3L,y3L)
     leaves3LL2 = {1,2,3};
     EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
     reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
     N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)
     netList computeParameterization(N3LL2,M3L,includeQs => false) -- parametrization without the Fourier coordinates
     netList computeParameterization(N3LL2,M3L)
  SeeAlso
    (getModel,List,HashTable)
    (getNetwork,List,List,List)
///

doc /// 
  Key
    getModel
    (getModel,List,HashTable)
  Headline
    A constructor method for the Model data type
  Usage
    getModel(necleotideSequence,transformTable)
  Inputs
    necleotideSequence: List
       a list of nucleotides used in the model
    transformTable: HashTable
       a hash table indicating the representatives and converters for the model
  Outputs
    M: Model
       a Model data type including the nucleotide sequence and transform table
  Description
    Text
      The following example constructs a Model data type for the Jukes-Cantor model.
    Example
      y3L = hashTable{A => 0, C => 1, G => 2, T => 3};
      L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
      M3L = getModel(L3L,y3L)
///


doc /// 
  Key
    getNucleotideSequence
    (getNucleotideSequence,Model)
  Headline
    An accessor method for the nucleotide sequence of a Model data type
  Usage
    getNucleotideSequence(Model)
  Inputs
    M: Model
       a Model data type including the nucleotide sequence and transform table
  Outputs
    nucleotideSequence: VerticalList
       a VerticalList  of nucleotides used in the model
  Description
    Text
       This method retrieves the nucleotide sequence from a given Model data type and return as a VerticalList.
    Example
       y3L = hashTable{A => 0, C => 1, G => 2, T => 3};
       L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
       M3L = getModel(L3L,y3L);
       getNucleotideSequence M3L
  SeeAlso
    (getModel,List,HashTable)
///

doc ///
  Key
    getTransformTable
    (getTransformTable,Model)
  Headline
    An accessor method for the transform table of a Model data type
  Usage
    getTransformTable(Model)
  Inputs
    M: Model
       a Model data type including the nucleotide sequence and transform table
  Outputs
    transformTable: HashTable
       a hash table indicating the representatives and converters for the model
  Description
    Text
       This method retrieves the hash table from a given Model data type.
    Example
       y3L = hashTable{A => 0, C => 1, G => 2, T => 3};
       L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
       M3L = getModel(L3L,y3L);
       getTransformTable M3L
  SeeAlso
    (getModel,List,HashTable)
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
       a Network data type including the sorted edges, leaves, reticulation edges, and level of the network
  Description
    Text
      The following example constructs a Network data type for a 3-leaf level-2 network.
    Example
      leaves3LL2 = {1,2,3};
      EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)
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
       a Network data type including the sorted edges, leaves, reticulation edges, and level
  Outputs
    reticulationEdges: List
       a list of reticulation edges in the network, where each reticulation edge is represented as a list of two vertices
  Description
    Text
      This method retrieves the reticulation edges as a vertical list from a given Network data type.
    Example
      leaves3LL2 = {1,2,3};
      EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2);
      getReticulationEdges N3LL2
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
       a Network data type including the sorted edges, leaves, reticulation edges, and level
  Outputs
    edges: List
       a list of edges in the network, where each edge is represented as a list of two
  Description
    Text
      This method retrieves the edges as a vertical list from a given Network data type.
    Example
      leaves3LL2 = {1,2,3};
      EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2);
      getEdges N3LL2
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
       a Network data type including the sorted edges, leaves, reticulation edges, and level of the network
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
       a Network data type including the updated sorted edges, leaves, reticulation edges, and level of the network
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
      Given a three-leaf level-2 network N3LL2 and a Jukes-Cantor model M3L, the following example
      computes the parameterization of N3LL2 under M3L without the Fourier coordinates and then
      computes the dimension of the parameterization numerically.
    Example
      y3L = hashTable{A => 0, C => 1, G => 2, T => 3};
      L3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
      M3L = getModel(L3L,y3L)
      leaves3LL2 = {1,2,3};
      EPList3LL2 = {{2,7},{8,3},{4,5},{4,1},{4,6},{6,7},{5,8},{7,8},{5,6}};
      reticulationPairList3LL2 = {{{4,6},{5,6}},{{6,7},{7,8}}};
      N3LL2 = getNetwork(EPList3LL2,leaves3LL2,reticulationPairList3LL2)
      paramerterization = computeParameterization(N3LL2,M3L,includeQs => false) -- parametrization without the Fourier coordinates
      computeDimensionNumerically paramerterization
  SeeAlso
    (computeParameterization,Network,Model)
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
