# ImageNetDataset.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Julia-XAI.github.io/ImageNetDataset.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Julia-XAI.github.io/ImageNetDataset.jl/dev/)
[![Build Status](https://github.com/Julia-XAI/ImageNetDataset.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Julia-XAI/ImageNetDataset.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Code Style: Runic](https://img.shields.io/badge/code_style-%E1%9A%B1%E1%9A%A2%E1%9A%BE%E1%9B%81%E1%9A%B2-black)](https://github.com/fredrikekre/Runic.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Data loader for the ImageNet 2012 Classification Dataset (ILSVRC 2012-2017) in Julia.

## Installation 

The ImageNet dataset can be downloaded at [image-net.org](https://image-net.org/) 
after signing up and accepting the terms of access.
It is therefore required that you download this dataset manually.

[Installation instructions can be found in the documentation.](https://Julia-XAI.github.io/ImageNetDataset.jl/dev/installation/)

Afterwards, add this package via
```julia-repl
julia> ]add ImageNetDataset
```

## Examples
By default, the ImageNet dataset will be loaded with the `CenterCropNormalize` transformation.

This uses [JpegTurbo.jl](https://github.com/JuliaIO/JpegTurbo.jl) to open the image
and applies a center-cropping view to `(224, 224)` resolution to it.
Afterwards, the image is normalized over color channels using normalization constants 
which are compatible with most pretrained models from [Metalhead.jl](https://github.com/FluxML/Metalhead.jl).
The output is in `WHC[N]` format (width, height, color channels, batchsize).

```julia
using ImageNetDataset

dataset = ImageNet(:val)            # load validation set
X, y = dataset[1:5]                 # load features and targets

convert2image(dataset, X)           # convert features back to images

class(dataset, y)                   # obtain class names
```

### Preprocessing
The dataset can also be loaded in a custom size with custom normalization parameters
by configuring the preprocessing transformations.
ImageNetDataset.jl currently provides `CenterCropNormalize` and `RandomCropNormalize`:

```julia
output_size = (224, 224)
mean = (0.485f0, 0.456f0, 0.406f0)
std  = (0.229f0, 0.224f0, 0.225f0)

tfm = CenterCropNormalize(; output_size, mean, std)

dataset = ImageNet(:val; transform=tfm)
```

Custom transformations can be implemented by extending `AbstractTransformation`.

To apply a transformation outside of the `ImageNet` dataset,
e.g. to preprocess a single image at a given `path`, run

```julia
transform(tfm, path)
```

### DataAugmentation.jl compatibility
Alternatively, ImageNetDataset is compatible with transformations from 
[DataAugmentation.jl](https://github.com/FluxML/DataAugmentation.jl/):

```julia
using ImageNetDataset, DataAugmentation

tfm = CenterResizeCrop((224, 224)) |> ImageToTensor() |> Normalize(mean, std)

dataset = ImageNet(:val; transform=tfm)
```

## Related packages

* [MLDatasets.jl](https://github.com/JuliaML/MLDatasets.jl): Utility package for accessing common Machine Learning datasets in Julia

> [!NOTE]
> This repository is based on [MLDatasets.jl PR #146](https://github.com/JuliaML/MLDatasets.jl/pull/146)
> and mirrors the MLDatasets `v0.7` API.
>
> Copyright (c) 2015 Hiroyuki Shindo and contributors.

## Acknowledgements

Adrian Hill gratefully acknowledges funding from the German Federal Ministry of Education and Research under the grant BIFOLD25B.
