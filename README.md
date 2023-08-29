# InnocentMoTMo
Scripts for the analysis of the innocent agent rates from the MoTMo model.
Application of the Augmented Jump Chain (AJC), PCCA+ and the shortest path problem to extract the most likely transition path between metastable clusters in a nonautonomous setting.

# Contents
- `clusterQtxt.jl`: read the sparse single timestep matrix `ratesStep01.txt` and compute the Schur/PCCA $\chi$ function
- `plot.jl`: Visualization of the 4-dimensional $\chi$ function on the 3-simplex / tetrahedron.
- `shortestpath.jl`: Compute the most likely (shortest in inverse rates) path between two clusters / vertices.
- `presentation.jl`: Reconstruct the plot from the presentation (transition paths of the AJC).

# Installation 
- Besides the packages in the `Project.toml` it requires the non-published [PCCA.jl](https://github.com/axsk/PCCA.jl): \
    `using Pkg; Pkg.add("https://github.com/axsk/PCCA.jl")`
- Also, depending on the usage it requires the whole AJC matrix `Q_matrix.mat` and `chi4.mat` or the single timestep rate matrix `ratesStep01.txt`.
