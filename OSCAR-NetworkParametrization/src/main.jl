module Main

include("NetworkTypes.jl")
include("Helpers.jl")
include("SigmaGeneration.jl")
include("Parametrization.jl")

using .NetworkTypes
using .Helpers
using .SigmaGeneration
using .Parametrization

export Network, Model, computeParametrization

end
