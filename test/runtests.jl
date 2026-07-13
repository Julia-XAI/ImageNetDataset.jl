using ImageNetDataset
using Test
using ReferenceTests

@testset "ImageNetDataset.jl" begin
    @testset verbose = true "Linting" begin
        @info "Running linting tests..."
        include("linting.jl")
    end
    @testset "Preprocessing" begin
        @info "Testing preprocessing..."
        include("test_preprocessing.jl")
    end
end
