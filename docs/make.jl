using ImageNetDataset
using Documenter

DocMeta.setdocmeta!(
    ImageNetDataset, :DocTestSetup, :(using ImageNetDataset); recursive = true
)

makedocs(;
    modules = [ImageNetDataset],
    authors = "Adrian Hill <gh@adrianhill.de>",
    sitename = "ImageNetDataset.jl",
    format = Documenter.HTML(;
        canonical = "https://Julia-XAI.github.io/ImageNetDataset.jl",
        edit_link = "main",
        assets = String[],
    ),
    pages = ["Home" => "index.md", "Installation" => "installation.md"],
)

deploydocs(; repo = "github.com/Julia-XAI/ImageNetDataset.jl", devbranch = "main")
