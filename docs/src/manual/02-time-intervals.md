# [Time intervals](@id timeintervals)

The operations with timescales naturally results in time intervals
(`TimeDelta`). These can be added or substracted to a `SystemTime`,
resulting in another `SystemTime`. `TimeDelta` is also the result of
substracting two `SystemTime` —representing the time difference between them—,
and of the addition/subtraction of `TimeDelta`s.

## Type hierarchy

All time interval are subtypes of `TimeDelta`. It is an abstract type with two
concrete subtypes, each with a different precision. `CoarseTimeDelta` has second
precision, whereas `FineTimeDelta` is used to represent intervals with
sub-second precision.

```jldoctest intervals
julia> using GnssDates

julia> CoarseTimeDelta(3, 127) # 3 weeks, 127 seconds
CoarseTimeDelta(3, 127)

julia> CoarseTimeDelta(-5, 127) # -5 weeks, +127 seconds -> -4 weeks, -604673 seconds
CoarseTimeDelta(-4, -604673)

julia> FineTimeDelta(10, 127, -0.5) # 10 weeks, 127 seconds, -0.5 seconds -> 10 weeks, 126 seconds, 0.5 seconds
FineTimeDelta(10, 126, 0.5)
```

`CoarseTimeDelta` intervals arise from operating two `CoarseTime`s, and the
result of operating a `T <: CoarseTime` with a `CoarseTimeDelta` will be another
`T <: CoarseTime`.

Any operation involving `FineTimeDelta` or `FineTime` will always result in
`FineTimeDelta` or `FineTime`.
