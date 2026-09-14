module Parametrization

using Oscar
import Singular

using ..NetworkTypes
using ..Helpers
using ..SigmaGeneration

export computeParametrization


function computeParametrization(N::Network, M::Model, includeQs::Bool)
    println("Computing parameterization...")

    nLeaves = length(getLeaves(N))
    y = getConverter(M)
    L = getReps(M)
    edges = getEdges(N)

    edge_syms = [Symbol("e_$(i)") for i in edges]
    a_syms = [Symbol("a_$(i)") for i in edges]
    b_syms = [Symbol("b_$(i)") for i in edges]
    leaf_syms = [Symbol("i_$i") for i in 1:nLeaves]
    varList = vcat(edge_syms, a_syms, b_syms, leaf_syms)

    # Use Singular polynomial ring (not Oscar.polynomial_ring)
    # R, vars = Singular.polynomial_ring(Singular.QQ, string.(varList))
    strList = string.(varList)
    println("stringified variable names: ", strList)
    R, vars = polynomial_ring(Oscar.QQ, string.(varList))


    @show typeof(vars)
    @show vars[1]

    # Boolean ideal
    varSqList = [v^2 for v in vars[1:3*length(edges)]]
    I = Singular.Ideal(R, varSqList...)


    # # Quotient ring using Singular
    # Q = Singular.Singular.QuotientRing(R, Singular.groebner(I))


    # println("Created quotient ring with Boolean relations.")

    # # Placeholder sigma
    # ##sigma = generateSigma(N, R)  # we can update this to use Q later
    # sigma = 0  # Just test bypassing for now
    # println("Generated sigma (placeholder).")

    # return Q, vars, I, sigma
end


end
