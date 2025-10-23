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
   JCNetworkParameterization
  Headline
     A Macaulay2 package to work with Phylogenetics Identifiability.
  Description
   Text
    {\em JCNetworkParameterization} is a package that can find the parameterization of a given network
--  Caveat
  Subnodes
    computeParameterization
///



doc ///
  Key
   computeParameterization
   (computeParameterization,Network,Model,Boolean)
  Headline
    Compute the parameterization of a given network under a given model
  Usage
    computeParameterization(N,M,includeQ)
  Inputs
   N: Network
      a network indicating the edges, leaves, reticulation edges, and level of the network.
   M: Model
      a model including the information about the representatives and converters
   includeQ: Boolean
      a boolean value indicating whether the fourier coordinates should be included in the parameterization
  Outputs
   parameterization: List
      a list of polynomials from the parameterization
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
