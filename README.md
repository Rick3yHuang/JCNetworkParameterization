# Phylogenetics-Identifiability

JCNetworkParameterization is a M2 package that can find the parameterization of a given network

Function ```computeParameterization``` of this package can be used to compute the parameterization of given network under a given model

A ```Network``` ```N``` contains informations of edges, leaves, reticulation edges, and level of the network

A ```Model``` ```M``` contains information of the nuclotide sequence and transformation table for the Fourier coordinates

The usage of ```computeParameterization``` is ```computeParameterization(M,N,includeQs)```, and the output is a list of polynomials as the parameterizations of the Network ```N``` under the model ```M```

```includeQs``` is an optional input as a ```Boolean```
- If ```includeQs => true``` then the Fourier coodinates are included in the parameterization
- If ```includeQs => false``` then the Fourier coodinates are not included in the parameterization
