# Phylogenetics-Identifiability

```JCNetworkParameterization``` is a ```Macaulay2``` package that can find the parameterization of a given network

## Data Types

A ```Network``` ```N``` contains informations of edges, leaves, reticulation edges, and level of the network

A ```Model``` ```M``` contains information of the nuclotide sequence and transformation table for the Fourier coordinates

## Key Method Functions

Function ```computeParameterization``` of this package can be used to compute the parameterization of given network under a given model

The usage of ```computeParameterization``` is ```computeParameterization(M,N,includeQs)```, and the output is a list of polynomials as the parameterizations of the Network ```N``` under the model ```M```

```includeQs``` is an optional input as a ```Boolean```
- If ```includeQs => true``` then the Fourier coodinates are included in the parameterization
- If ```includeQs => false``` then the Fourier coodinates are not included in the parameterization

Function ```addNetworkEdges``` provides a faster way to construct a network

One usage of ```addNetworkEdges``` is ```addNetworkEdges(N,edgesToDivide,vertexInNewReticulation)```, and the output is a new network that has level +1

- ```N``` is a Network object, e.g. a network with edges ${e_{1,8},e_{2,7},e_{3,6},e_{4,5},e_{5,6},e_{6,7},e_{7,8},e_{5,8}}$
- ```edgesToDivide``` is a list that contains a pair of edges, e.g. {{1,8},{7,2}}
- ```vertexInNewReticulation``` is an integer representing a vertex's index, e.g. 7
- example: edges $e_{1,8}$ and $e_{2,7}$ will be subdivide to create new vertices $9$ and $10$. This will create new edges $e_{1,9},e_{8,9},e_{2,10},e_{7,10}$, and $e_{9,10}$. The edge $e_{9,10}$ will be chosen to be one of the new reticulation edges, and since ```vertexInNewReticulation``` is assigned to be $7$, the other edge in the new reticulation pair will be $e_{7,10}$

```addNetworkEdges``` is override with another usage of addNetworkEdge(N,listOfEdgesToDivide,listOfVerticesInNewReticulation)```

- ```listOfEdgesToDivide``` is a list of edges to divide in order, e.g. {{{1,8},{7,2}},{{3,6},{4,5}}}
- ```listOfVerticesInNewReticulation``` is a list of vertex indices indicating the edge in the new reticulation pairs, e.g. {7,3}
