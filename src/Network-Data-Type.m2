---------------------------------------------------------------------
--- Define a data type for representing phylogenetic networks--------
---------------------------------------------------------------------
Network = new Type of MutableHashTable

-- Define a constructor for the Network data type
getNetwork = method()
getNetwork (List,List,List) := (EPListSorted,leaves,reticulationEdges) -> (
    new Network from {
        "sorted edges" => VerticalList sort apply(EPListSorted,ep -> sort(ep)),
        "leaves" => leaves,
        "reticulation edges" => VerticalList reticulationEdges,
	"level" => #reticulationEdges
    }
)

-- Define accessor methods for the Network data type
getEdges = method()
getEdges Network := N -> VerticalList N#"sorted edges"
getLeaves = method()
getLeaves Network := N -> N#"leaves"
getReticulationEdges = method()
getReticulationEdges Network := N -> VerticalList  N#"reticulation edges"
getLevel = method()
getLevel Network := N -> N#"level"

---------------------------------------------------------------------
--- Define a data type for representing models-----------------------
---------------------------------------------------------------------
FourierIndices = new Type of MutableHashTable

-- Define a constructor for the Model data type
getFourierIndices = method()
getFourierIndices (List,HashTable) := (leafPatternClasses,groupLabeling) -> (
    new FourierIndices from {
        "leaf pattern classes" => leafPatternClasses,
        "group labeling" => groupLabeling
    }
)

-- Define accessor methods for the Model data type
getLeafPatternClasses = method()
getLeafPatternClasses FourierIndices := FI -> VerticalList FI#"leaf pattern classes"
getGroupLabeling = method()
getGroupLabeling FourierIndices := FI -> FI#"group labeling"
