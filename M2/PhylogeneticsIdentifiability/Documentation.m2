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
    "getNetwork",
    "getModel",
    "getEdges",
    "iMap",
    "generateSigma",
    "generateQ"
}

doc ///
  Key
   PhylogeneticsIdentifiability
  Headline
     A Macaulay2 package to work with Phylogenetics Identifiability.
  Description
   Text
    {\em PhylogeneticsIdentifiability} is a package that can find the parametrization of a given network
--  Caveat
  Subnodes
    computeParametrization
///



doc ///
  Key
   computeParametrization
   (computeParametrization,Network,Model,Boolean)
  Headline
    Compute the parametrization of a given network under a given model
  Usage
    computeParametrization(N,M,includeQ)
  Inputs
   N: Network
      a network indicating the edges, leaves, reticulation edges, and level of the network.
   M: Model
      a model including the information about the representatives and converters
   includeQ: Boolean
      a boolean value indicating whether the fourier coordinates should be included in the parametrization
  Outputs
   parametrization: List
      a list of polynomials from the parametrization
  Description
   Text
     Here is an example.
///


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
