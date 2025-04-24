module Helpers

using ..NetworkTypes

export getLeaves, getEdges, getReticulationEdges, getConverter, getReps

function getLeaves(N::Network)
    n = length(N.edges)
    return N.edges[1:min(4, n)]
end

getEdges(N::Network) = N.edges
getReticulationEdges(N::Network) = N.reticulations
getConverter(M::Model) = M.converter
getReps(M::Model) = M.reps

end
