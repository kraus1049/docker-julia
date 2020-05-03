FROM julia:1.4.1
LABEL maintainer="kraus1049 <kraus1049@gmail.com>"

RUN apt-get update && apt-get install -y \
    gcc \
    clang && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG USER=jovyan
ARG UID=1000
ARG GROUP=jovyan_g
ARG GID=1000
ENV HOME="/home/$USER"
RUN groupadd -g $GID $GROUP
RUN useradd -g $GID -m -u $UID $USER
USER $USER

RUN julia -e 'using Pkg; Pkg.add("QuadGK");using QuadGK'
RUN julia -e 'using Pkg; Pkg.add("FFTW");using FFTW'
RUN julia -e 'using Pkg; Pkg.add("DataFrames"); using DataFrames'
RUN julia -e 'using Pkg; Pkg.add("DataFramesMeta"); using DataFramesMeta'
RUN julia -e 'using Pkg; Pkg.add("JuMP"); using JuMP'
RUN julia -e 'using Pkg; Pkg.add("CSV"); using CSV'
RUN julia -e 'using Pkg; Pkg.add("Match"); using Match'
RUN julia -e 'using Pkg; Pkg.add("Roots"); using Roots'
RUN julia -e 'using Pkg; Pkg.add("Memoize"); using Memoize'
RUN julia -e 'using Pkg; Pkg.add("HDF5"); using HDF5'
RUN julia -e 'using Pkg; Pkg.add("ProgressBars"); using ProgressBars'
RUN julia -e 'using Pkg; Pkg.add("ProgressMeter"); using ProgressMeter'
RUN julia -e 'using Pkg; Pkg.add("StatsBase"); using StatsBase'
RUN julia -e 'using Pkg; Pkg.add("StatsFuns"); using StatsFuns'
RUN julia -e 'using Pkg; Pkg.add("Nullables"); using Nullables'
RUN julia -e 'using Pkg; Pkg.add("ForwardDiff"); using ForwardDiff'
RUN julia -e 'using Pkg; Pkg.add("Optim"); using Optim'
RUN julia -e 'using Pkg; Pkg.add("UnicodePlots"); using UnicodePlots'
RUN julia -e 'using Pkg; Pkg.add("Unitful"); using Unitful'
RUN julia -e 'using Pkg; Pkg.add("Pipe"); using Pipe'
RUN julia -e 'using Pkg; Pkg.add("DualNumbers"); using DualNumbers'
RUN julia -e 'using Pkg; Pkg.add("Parameters"); using Parameters'
RUN julia -e 'using Pkg; Pkg.add("LaTeXStrings"); using LaTeXStrings'
RUN julia -e 'using Pkg; Pkg.add("HTTP"); using HTTP'
RUN julia -e 'using Pkg; Pkg.add("JSON"); using JSON'
RUN julia -e 'using Pkg; Pkg.add("IntervalRootFinding"); using IntervalRootFinding'
RUN julia -e 'using Pkg; Pkg.add("IntervalOptimisation"); using IntervalOptimisation'
RUN julia -e 'using Pkg; Pkg.add("IntervalArithmetic"); using IntervalArithmetic'
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(url="https://github.com/JuliaLang/PackageCompiler.jl",rev="master")); using PackageCompiler'
RUN julia -e 'using Pkg; Pkg.add("OhMyREPL"); using OhMyREPL'
RUN julia -e 'using Pkg; Pkg.add("SpecialFunctions"); using SpecialFunctions'
RUN julia -e 'using Pkg; Pkg.add("IntervalSets"); using IntervalSets'
RUN julia -e 'using Pkg; Pkg.add("Decimals"); using Decimals'
RUN julia -e 'using Pkg; Pkg.add("Cbc"); using Cbc'
RUN julia -e 'using Pkg; Pkg.add("Clp"); using Clp'
RUN julia -e 'using Pkg; Pkg.add("COSMO"); using COSMO'
RUN julia -e 'using Pkg; Pkg.add("GLPK"); using GLPK'
RUN julia -e 'using Pkg; Pkg.add("Ipopt"); using Ipopt'
RUN julia -e 'using Pkg; Pkg.add("BlackBoxOptim"); using BlackBoxOptim'
# RUN julia -e 'Pkg.add("CPLEX");Pkg.build("CPLEX");'
# RUN julia -e 'Pkg.add("Gurobi");'


RUN julia -e 'using PackageCompiler; create_sysimage([:OhMyREPL, :CSV, :QuadGK, :FFTW, :DataFrames, :DataFramesMeta, :Roots, :SpecialFunctions, :UnicodePlots],sysimage_path=joinpath(ENV["HOME"],".julia/compiled-julia.so"))'
RUN echo "using OhMyREPL" >> "$HOME/.julia/startup.jl"

CMD ["julia", "-J", "/home/jovyan/.julia/compiled-julia.so"]