-*- coding: utf-8 -*-
newPackage("JCNetworkParametrization",
    AuxiliaryFiles => true, 
    Version => "0.1",
    Date => "June 10, 2025",
    Authors => {
	{Name => "Hawai`i Phylogentics Identifibillity group"
	    --Email => 
	    --HomePage => 
	    }
	},
    Headline => "A phylogenetics identifibality package that implements methods for generating parametrizations of phylogenetic networks under the Jukes-Cantor model.",
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
    "computeParametrization",
    "generateSigma",
    "generateQ"
    }

baseDirectory = JCNetworkParametrization#"source directory"
--------------------------------------------------------------------
----- CODE
--------------------------------------------------------------------
-- Data
load(baseDirectory | "JCNetworkParametrization/Network-Data-Type.m2")
-- Methods
load(baseDirectory | "JCNetworkParametrization/Parametrization-Generation.m2")
--------------------------------------------------------------------
----- TESTS
--------------------------------------------------------------------
--load(baseDirectory | "JCNetworkParametrization/TESTS/Test-Parameter-Generation.m2")
--------------------------------------------------------------------
----- DOCUMENTATION
--------------------------------------------------------------------
beginDocumentation()
load(baseDirectory | "JCNetworkParametrization/Documentation.m2")
end

--------------------------------------------------------------------
----- SCRATCH SPACE
--------------------------------------------------------------------
restart
uninstallPackage "JCNetworkParametrization"
installPackage "JCNetworkParametrization"
needsPackage "JCNetworkParametrization"
--check "JCNetworkParametrization"

