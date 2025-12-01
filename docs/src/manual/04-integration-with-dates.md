# [Integration with `Dates`](@id datesintegration)

It is very likely that a user needs to convert back and forth from a GNSS
time representation and a more human-readable one. `GnssDates` leverages the
standard library `Dates` to provide this functionality.

## `DateTime` and `Date`

Conversion to/from `DateTime` and `AbstractGnssTime` works either via `Base.convert`
or with a constructor directly. `DateTime`s beyond the origin of the timescale
are supported. It assumes that all `DateTime`s are in UTC.

```jldoctest datesinteg
julia> using GnssDates

julia> using Dates

julia> Base.convert(DateTime, GST(1351, 496170))
2025-07-18T17:49:12

julia> DateTime(GST(1351, 496170))
2025-07-18T17:49:12

julia> Date(GST(1351, 496170))
2025-07-18
```
