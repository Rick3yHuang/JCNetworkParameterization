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
    computeParameterization
    getModel
    getNucleotideSequence
    getTransformTable
    getNetwork
    getReticulationEdges
    getEdges
    addNetworkEdge
    generateSigma
    generateQ
    Network
    Model
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
     
///

doc /// 
  Key
    getModel
    (getModel,List,HashTable)
  Headline
    An accessor method for the Model data type
  Usage
    getModel(necleotideSequence,transformTable)
  Inputs
    necleotideSequence: List
       a list of nucleotides used in the model
    transformTable: HashTable
       a hash table indicating the representatives and converters for the model
  Outputs
    Model: Model
       a Model data type including the nucleotide sequence and transform table
  Description
    Text
    
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
    nucleotideSequence: List
       a list of nucleotides used in the model
  Description
    Text

  SeeAlso
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

  SeeAlso
///

doc /// 
  Key
    getNetwork
    (getNetwork,List,List,List)
  Headline
    An accessor method for the Network data type
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

  SeeAlso
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

  SeeAlso
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

  SeeAlso
///

doc /// 
  Key
    addNetworkEdge
    (addNetworkEdge,Network,List,ZZ)
    (addNetworkEdge,Network,List,List)
  Headline
    Add an edge to a given network
  Usage
    addNetworkEdge(N,edgesToDivide,vertexInNewReticulation)
    addNetworkEdge(N,edgesToDivideList,vertexInNewReticulationList)
  Inputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and level of the network
    edgesToDivide: List
       a list of two edges to divide when adding a new edge
    vertexInNewReticulation: ZZ
       an integer representing the vertex in the new reticulation edge
        edgesToDivideList: List
       a list of lists of two edges to divide when adding new edges
    vertexInNewReticulationList: List
       a list of integers representing the vertices in the new reticulation edges
  Outputs
    NNew: Network
       a Network data type including the updated sorted edges, leaves, reticulation edges, and level of the network
  Description
    Text

  SeeAlso
///

doc /// 
  Key
    generateSigma
    (generateSigma,Network,Ring)
  Headline
    Generate the Sigma matrix for a given model
  Usage
    generateSigma(Network,Ring)
  Inputs
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and level
    R: Ring
       a ring over which the Sigma matrix will be generated
  Outputs
    Sigma: Matrix
       a matrix representing the Sigma matrix for the given model
  Description
    Text

  SeeAlso
///

doc /// 
  Key
    generateQ
    (generateQ,Matrix,Network,Sequence,Ring)
  Headline
    Generate the a polynomial q in the ring R for a given model and network
  Usage
    generateQ(matrix,Network,Sequence,Ring)
  Inputs
    M: Matrix
       a matrix representing the Sigma matrix for the given model
    N: Network
       a Network data type including the sorted edges, leaves, reticulation edges, and level
    seq: Sequence
       a sequence representing the nucleotides in the model
    R: Ring
       a ring over which the Q matrix will be generated
  Outputs
    qPoly: RingElement
       a polynomial in the ring R representing the q polynomial for the given model and network
  Description
    Text

  SeeAlso
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

  SeeAlso
///
