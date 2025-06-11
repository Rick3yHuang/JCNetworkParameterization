-*- coding: utf-8 -*-
newPackage("PhylogeneticsIdentifiability",
    AuxiliaryFiles => true, 
    Version => "0.1",
    Date => "June 10, 2025",
    Authors => {
	{Name => "Hawai`i Phylogentics Identifibillity group"
	    --Email => "rickey.huang747@gmail.com",
	    --HomePage => "https://sites.gatech.edu/rickeyhuang77/"
	    }
	},
    Headline => "Phylogenetics Identifibality Package",
    Keywords => {"Phylogentics"},
    PackageImports => {"Graphs"},
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

baseDirectory = PhylogeneticsIdentifiability#"source directory"
--------------------------------------------------------------------
----- CODE
--------------------------------------------------------------------
-- Data
load(baseDirectory | "PhylogeneticsIdentifiability/Network-Data-Type.m2")
-- Methods
load(baseDirectory | "PhylogeneticsIdentifiability/Parametrization-Generation.m2")
--------------------------------------------------------------------
----- TESTS
--------------------------------------------------------------------
--load(baseDirectory | "PhylogeneticsIdentifiability/TESTS/Test-Parameter-Generation.m2")
--------------------------------------------------------------------
----- DOCUMENTATION
--------------------------------------------------------------------
beginDocumentation()
load(baseDirectory | "PhylogeneticsIdentifiability/Documentation.m2")
end

--------------------------------------------------------------------
----- SCRATCH SPACE
--------------------------------------------------------------------
restart
uninstallPackage "PhylogeneticsIdentifiability"
installPackage "PhylogeneticsIdentifiability"
needsPackage "PhylogeneticsIdentifiability"
debug "PhylogeneticsIdentifiability"
check "PhylogeneticsIdentifiability"

