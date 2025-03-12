# GnssDates

[![Stable Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://nandoconde.github.io/GnssDates.jl/stable)
[![In development documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://nandoconde.github.io/GnssDates.jl/dev)
[![codecov](https://codecov.io/gh/nandoconde/GnssDates.jl/graph/badge.svg?token=ODZYAYBP10)](https://codecov.io/gh/nandoconde/GnssDates.jl)

## Installation

```julia-repl
julia> using Pkg

julia> Pkg.add("GnssDates")
```

## Quick start

[Check the documentation](@ref index) for
the complete API and more examples.

```julia-repl
julia> using GnssDates

julia> gst = GST(967, 432000)
GST(967, 432000)

julia> gpst = GPST(1991, 432127)
GPST(1991, 432127)

julia> gpst - gst
CoarseTimeDelta(0, 127)

julia> gst + FineTimeDelta(0, 127, 0.7774)
GnssTime(1991, 432127, 0.7774)

julia>  gst < gpst
true
```

## Contributing

If you want to make contributions of any kind, please first take a look into the
[contributing page on the docs](@ref contributing)
