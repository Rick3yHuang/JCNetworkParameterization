
# Parametrization computation of phylogenetic network under the Jukes-Cantor model

## Ideal Stabilization

`JCNetworkParameterization/analysis/` contains computations to study network families
- half-ziggurat family
- spiral family
- ladder family
- zig-zag ladder family

To confirm the ideal stabilization results in [Arxiv link of the paper], start Macaulay2 under `JCNetworkParameterization/analysis/` and run
```
needs "run-all.m2"
```
To study a new network family, write a new network constructor under a new family directory and add a new line for this family following
```
networkFamilies = {
    ("half-ziggurat-family/network-constructor.m2",   6,  12,  3),
    ("spiral-family/network-constructor.m2",	      7,  15,  3),
    ("ladder-family/network-constructor.m2",	      5,  9,   2),
    ("zig-zag-ladder-family/network-constructor.m2",  5,  11,  3)
    }
```
in `JCNetworkParameterization/analysis/run-all.m2`. The data list here for each family are 
- network constructor path,
- max level of the network,
- dimension of the stabilization ideal, and
- the max degree of generators computed for the stabilization ideal.

Our experiments utilizes the methods from the following Macaulay2 package.

## Package ```JCNetworkParameterization```

```JCNetworkParameterization``` is a ```Macaulay2``` package that can find the parameterization of a given phylogenetic network under Jukes-Cantor model.

To build documentation, start Macaulay2 under `JCNetworkParameterization/src/` and run
```
installPackage "JCNetworkParameterization"
viewHelp "JCNetworkParameterization"
```
