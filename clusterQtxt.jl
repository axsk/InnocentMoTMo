"""
read a Q matrix from a .txt in ijv format
and use PCCA to cluster it
requires the PCCA pkg to be installed:
`Pkg.add("https://github.com/axsk/PCCA.jl")`
"""

using SparseArrays
using LinearAlgebra
using PCCA
using MAT
using NPZ

file = "/data/numerik/ag_cmd/anPraktikantin/ratesStep01.txt"

data = reduce(hcat, (split.(readlines(file), ',')))

i = parse.(Int, data[1, :]) .- 30000000 .+ 1
j = parse.(Int, data[2, :]) .- 30000000 .+ 1
v = parse.(Float64, data[3, :])

Q = sparse(i, j, v)

Q[diagind(Q)] .= 0
Q[diagind(Q)] .= -sum(Q, dims=2)

p = ones(size(Q, 1))
n = 4
solver = PCCA.ArnoldiSolver()
optim = true

X, lam = PCCA.schurvectors(Q, p, n, optim, solver)

chi = PCCA.makeprobabilistic(X, true)

write = false
if write
    matwrite("out/ratesStep01.mat", Dict("Q" => Q, "X" => X, "chi" => chi))
    matwrite("out/ratesStep01_withoutQ.mat", Dict("X" => X, "chi" => chi))
    npzwrite("out/ratesStep01_withoutQ.npz", Dict("X" => X, "chi" => chi))
end