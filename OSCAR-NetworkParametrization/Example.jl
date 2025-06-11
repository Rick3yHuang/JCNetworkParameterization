using Oscar
include("src/Main.jl")

using .Main

edges = [(1, 5), (2, 6), (3, 7), (4, 8), (5, 6), (6, 7), (7, 8)]
reticulations = [[(6,7), (7,8)]]
net = Network(edges, reticulations)

example_converter = x -> x  # identity placeholder
reps = [[:A, :G, :C], [:T, :C, :A], [:G, :G, :T]]
model = Model(example_converter, reps)

computeParametrization(net, model, false)
