module NetworkTypes

export Network, Model

struct Network
    edges::Vector{Tuple{Int, Int}}
    reticulations::Vector{Vector{Tuple{Int, Int}}}
end

struct Model
    converter::Function
    reps::Vector{Vector{Symbol}}
end

end
