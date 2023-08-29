using Plots

function euclidean_coords_simplex()
    s1 = [0, 0, 0]
    s2 = [1, 0, 0]
    s3 = [0.5, sqrt(3) / 2, 0]
    s4 = [0.5, sqrt(3) / 4, sqrt(3) / 2]
    hcat(s1, s2, s3, s4)'
end

function plot_simplex(; kwargs...)
    c = euclidean_coords_simplex()
    for i in 1:4, j in i+1:4
        plot!(eachcol(c[[i, j], :])...; kwargs...)
    end
    plot!()
end


function bary_to_euclidean(x::AbstractMatrix)
    x * euclidean_coords_simplex()
end


function scatter_chi(chi; kwargs...)
    c = bary_to_euclidean(chi)
    scatter!(eachcol(c)...; kwargs...)
end

function plot_path(chi, path; kwargs...)
    plot!(eachcol(bary_to_euclidean(chi[path, :]))...; kwargs...)
end


