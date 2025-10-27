---------------------------------------------------------------------
--- Define a data type for representing phylogenetic networks--------
---------------------------------------------------------------------
Network = new Type of MutableHashTable

-- Define a constructor for the Network data type
getNetwork = method()
getNetwork (List,List,List) := (EPListSorted,leaves,reticulationEdges) -> (
    new Network from {
        "sorted edges" => sort apply(EPListSorted,ep -> sort(ep)),
        "leaves" => leaves,
        "reticulation edges" => reticulationEdges,
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
Model = new Type of MutableHashTable

-- Define a constructor for the Model data type
getModel = method()
getModel (List,HashTable) := (necleotideSequence,transformTable) -> (
    new Model from {
        "nucleotide sequence" => necleotideSequence,
        "transform table" => transformTable
    }
)

-- Define accessor methods for the Model data type
getNucleotideSequence = method()
getNucleotideSequence Model := M -> VerticalList M#"nucleotide sequence"
getTransformTable = method()
getTransformTable Model := M -> M#"transform table"
