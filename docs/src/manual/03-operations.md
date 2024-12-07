# [Operations with `SystemTime` and `TimeDelta`](@id operations)

## Operating with `SystemTime`s

The time difference between two `CoarseTime` results in a `CoarseTimeDelta`.

```jldoctest operations
julia> using GnssDates

julia> GST(967, 432000) - GPST(1991, 431999)
CoarseTimeDelta(0, 1)
```

The time difference between a `FineTime` and any other `SystemTime` results in
a `FineTimeDelta`.

```jldoctest operations
julia> GnssTime(1991, 432000, 0.0) - GPST(1991, 431999)
FineTimeDelta(0, 1, 0.0)

julia> GST(967, 432000) - GnssTime(1991, 431999, 0.0)
FineTimeDelta(0, 1, 0.0)
```

## Operating with `TimeDelta`

The subtraction or addition of two `CoarseTimeDelta` results in a
`CoarseTimeDelta`, but the subtraction or addition of a `FineTimeDelta` to any
`TimeDelta` will always result in a `FineTimeDelta`.

```jldoctest operations
julia> CoarseTimeDelta(10, 30) + CoarseTimeDelta(-7, -31)
CoarseTimeDelta(2, 604799)

julia> FineTimeDelta(10, 30, 0.0) + CoarseTimeDelta(-7, -31)
FineTimeDelta(2, 604799, 0.0)

julia> CoarseTimeDelta(10, 30) - FineTimeDelta(7, 31, -0.5)
FineTimeDelta(2, 604799, 0.5)
```

The same happens with the subtraction or addition of a `SystemTime` and a
`TimeDelta`: operations between a `CoarseTime` and a `CoarseTimeDelta` result
in a `CoarseTime` of the same type. However, any operations between a
`SystemTime` and a`FineTimeDelta` will result in a `FineTime`.

```jldoctest operations
julia> GST(967, 432000) - CoarseTimeDelta(0, 1)
GST(967, 431999)

julia> GPST(1991, 431999) + CoarseTimeDelta(0, 1)
GPST(1991, 432000)

julia> GPST(1991, 431999) + FineTimeDelta(0, 1, 0.0)
GnssTime(1991, 432000, 0.0)
```

## Comparison

Finally, of course, usual comparison operators among and between `SystemTime`s
and `TimeDelta`s are defined.

```jldoctest operations
julia> GST(967, 432000) == GPST(1991, 432000)
true

julia> GST(967, 432000) == GnssTime(1991, 432000, 0.5)
false

julia> GST(967, 432000) == GnssTime(1991, 432000, 0.0)
true

julia> GST(967, 432000) < GnssTime(1991, 432000, 0.5)
true

julia> GST(967, 432000) >= GnssTime(1991, 432000, 0.0)
true

julia> CoarseTimeDelta(1, -1) == CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK - 1)
true

julia> FineTimeDelta(10, 5, 0.0) <= CoarseTimeDelta(10, 5)
true
```
