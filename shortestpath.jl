using Graphs
using MAT
using SparseArrays

println("reading in Q and χ")

Q = matread("anPraktikantin/Q_matrix.mat")["Q"]
chi = matread("anPraktikantin/chi4.mat")["z"]

subsize = size(Q, 1)

q = Q[1:subsize, 1:subsize]
chi1 = chi[1:subsize, 1]

I = Int[]
J = Int[]
V = Float64[]

# 1/q is the expected time for a transition, 
# thus the sum of the inverse rates along a path
# should be the average time to observe that path

# minimizing the path time leads to the most probable path

println("creating path matrix")

for (i, j, q) in zip(SparseArrays.findnz(q)...)
    delta = chi1[j] - chi1[i]
    delta <= 0 && continue
    push!(I, i)
    push!(J, j)
    push!(V, 1 / q)#* delta)
end

w = sparse(I, J, V, subsize, subsize)

println("computing shortest path")

from, to = argmin(chi1), argmax(chi1)
# i have no clue how this is so fast, and whether it makes any sense at all
@time p = a_star(DiGraph(w), from, to, w)

path = [map(x -> x.src, p); to]

println("saving path")

matwrite("path.mat", Dict("path" => path))