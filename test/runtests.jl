using ImageNetDataset
using Test
using Aqua
using JET
using ReferenceTests

@testset "ImageNetDataset.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        @info "Testing code quality (Aqua.jl)..."
        Aqua.test_all(ImageNetDataset; ambiguities=false)
    end
    @testset "Code linting (JET.jl)" begin
        @info "Testing code linting (JET.jl)..."
        if VERSION >= v"1.10"
            JET.test_package(ImageNetDataset; target_defined_modules=true)
        end
    end
    @testset "Preprocessing" begin
        @info "Testing preprocessing..."
        include("test_preprocessing.jl")
    end
end
