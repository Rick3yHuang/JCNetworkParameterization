-*- coding: utf-8 -*-
newPackage("JCNetworkParameterization",
    AuxiliaryFiles => true, 
    Version => "0.1",
    Date => "June 10, 2025",
    Authors => {
	{Name => "Hawai`i Phylogentics Identifibillity group"
	    --Email => 
	    --HomePage => 
	    }
	},
    Headline => "A phylogenetics identifiability package that implements methods for generating parameterizations of phylogenetic networks under the Jukes-Cantor model.",
    Keywords => {"Phylogentics"},
    PackageImports => {},
    DebuggingMode => true
    )

export {
    -- Data Type
    "Network",
    "Model",
    "getNetwork",
    "getModel",
    "getEdges",
    -- Methods
    "iMap",
    "computeParameterization",
    "generateSigma",
    "generateQ"
    }

baseDirectory = JCNetworkParameterization#"source directory"
--------------------------------------------------------------------
----- CODE
--------------------------------------------------------------------
-- Data
load(baseDirectory | "JCNetworkParameterization/Network-Data-Type.m2")
-- Methods
load(baseDirectory | "JCNetworkParameterization/Parameterization-Generation.m2")
--------------------------------------------------------------------
----- TESTS
--------------------------------------------------------------------
--load(baseDirectory | "JCNetworkParameterization/TESTS/Test-Parameter-Generation.m2")
--------------------------------------------------------------------
----- DOCUMENTATION
--------------------------------------------------------------------
beginDocumentation()
load(baseDirectory | "JCNetworkParameterization/Documentation.m2")
end

--------------------------------------------------------------------
----- SCRATCH SPACE
--------------------------------------------------------------------
restart
uninstallPackage "JCNetworkParameterization"
installPackage "JCNetworkParameterization"
needsPackage "JCNetworkParameterization"
--check "JCNetworkParameterization"

