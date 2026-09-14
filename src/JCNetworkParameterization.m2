-*- coding: utf-8 -*-
newPackage("JCNetworkParameterization",
    AuxiliaryFiles => true, --swap to true before building. jkl 2025-11-07
    Version => "0.1",
    Authors => {
		{Name => "Hawai`i Phylogentics Identifibillity group"
		    --Email => rhuang346@gatech.edu
		    --HomePage => 
		    }
		},
    HomePage => "https://github.com/Rick3yHuang/JCNetworkParameterization",
    Date => "June 10, 2025",
    Headline => "A phylogenetics identifiability package",
    Keywords => {"Phylogentics"},
    PackageImports => {},
    DebuggingMode => true,
    Configuration => {}
    )

export {
    -- Data Type
    "Network",
    "Model",
    "getNetwork",
    "getModel",
    "getEdges",
    "getReticulationEdges",
    "getNucleotideSequence",
    "getTransformTable",
    -- Methods
    "computeParameterization",
    "addNetworkEdge",
    "computeDimensionNumerically",
    -- Optional Inputs
    "includeQs"
    }

baseDirectory = JCNetworkParameterization#"source directory"
--------------------------------------------------------------------
----- CODE
--------------------------------------------------------------------
-- Data
load(baseDirectory | "Network-Data-Type.m2")
-- Methods
load(baseDirectory | "Parameterization-Generation.m2")
--------------------------------------------------------------------
----- TESTS
--------------------------------------------------------------------
--load(baseDirectory | "JCNetworkParameterization/TESTS/Test-Parameter-Generation.m2")
--------------------------------------------------------------------
----- DOCUMENTATION
--------------------------------------------------------------------
beginDocumentation()
load(baseDirectory | "../docs/Documentation.m2")
end

--------------------------------------------------------------------
----- BUILD DOCUMENTATION-- run this code to build documentation
--------------------------------------------------------------------
restart
uninstallPackage "JCNetworkParameterization"
installPackage "JCNetworkParameterization"
viewHelp "JCNetworkParameterization"
needsPackage "JCNetworkParameterization"
--check "JCNetworkParameterization"
