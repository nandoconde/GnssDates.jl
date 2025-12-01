# [Time intervals](@id timeintervals)

The operations with timescales naturally results in time intervals
(`AbstractTimeDelta`). These can be added or substracted to an `AbstractGnssTime`,
resulting in another `AbstractGnssTime`. `AbstractTimeDelta`s are also the result of
substracting two `AbstractGnssTime` —representing the time difference between them—,
and of the addition/subtraction of other `AbstractTimeDelta`s.

## Type hierarchy

All time interval are subtypes of `AbstractTimeDelta`. It is an abstract type with two
concrete subtypes, each with a different precision. `TimeDeltaCoarse` has second
precision, whereas `TimeDelta` is used to represent intervals with
sub-second precision (down to femtoseconds).

```jldoctest intervals
julia> using GnssDates

julia> TimeDeltaCoarse(3, 127) # 3 weeks, 127 seconds
TimeDeltaCoarse(3, 127)

julia> TimeDeltaCoarse(-5, 127) # -5 weeks, +127 seconds
TimeDeltaCoarse(-5, 127)

julia> TimeDelta(10, 127, -0.5) # 10 weeks, 127 seconds, -0.5 seconds -> 10 weeks, 126 seconds, 0.5 seconds
TimeDelta(10, 126, 0.5)
```

`TimeDeltaCoarse` intervals arise from operating two `GnssTimeCoarse`s, and the
result of operating a `GnssTimeCoarse` with a `TimeDeltaCoarse` will be another
`GnssTimeCoarse`.

Any operation involving `TimeDelta` or `GnssTime` will always result in
`TimeDelta` or `GnssTime`.
