Network = new Type of MutableHashTable

getNetwork = method()
getNetwork (List,List,List,ZZ) := (EPListSorted,leaves,reticulationEdges,level) -> (
    new Network from {
        "sorted edges" => EPListSorted,
        "leaves" => leaves,
        "reticulation edges" => reticulationEdges,
	"level" => level
    }
)

getEdges = method()
getEdges Network := N -> N#"sorted edges"
getLeaves = method()
getLeaves Network := N -> N#"leaves"
getReticulationEdges = method()
getReticulationEdges Network := N -> N#"reticulation edges"
getLevel = method()
getLevel Network := N -> N#"level"

Model = new Type of MutableHashTable

getModel = method()
getModel (List,HashTable) := (reps,converter) -> (
    new Model from {
        "representatives" => reps,
        "converter" => converter
    }
)

getReps = method()
getReps Model := M -> M#"representatives"
getConverter = method()
getConverter Model := M -> M#"converter"
