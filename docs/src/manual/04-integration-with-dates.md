# [Integration with `Dates`](@id datesintegration)

It is very likely that a user needs to convert back and forth from a GNSS
time representation and a more human-readable one. `GnssDates` leverages the
standard library `Dates` to provide this functionality.

## `DateTime`

Conversion to/from `DateTime` and `SystemTime` works either via `Base.convert`
or with a constructor directly. `DateTime`s beyond the origin of the timescale
are supported.

```jldoctest datesinteg
julia> using GnssDates

julia> using Dates

julia> Base.convert(DateTime, GST(967, 432000))
2018-03-09T00:00:00

julia> DateTime(GPST(0,0))
1980-01-06T00:00:00

julia> DateTime(GnssTime(0, -1, 0.9999))
1980-01-05T23:59:59.999
```

Note that the origin of the timescale is taken as the reference `DateTime` and
seconds elapsed in the GNSS timescale are added as they are to the reference
`DateTime` without accounting for leap seconds at all. For more information, see
the section below on UTC.

## `Date`

Conversion to a `Date` works similarly. The corresponding date is formed
counting whole days from the origin of the timescale.

```jldoctest datesinteg
julia> Base.convert(Date, GST(967, 432000))
2018-03-09

julia> Date(GnssTime(0,0, 0.1275))
1980-01-06

julia> Date(GPST(0,-1))
1980-01-05
```

## Relation with UTC

Since most `SystemTimes` (though not all, see GLONASS) are continuous timescales
and thus ot affected by leap seconds, they diverge from UTC time. To get the UTC
time exactly corresponding to a `SystemTime`, the `UTC` type supplied by the
`Dates` standard library is used as the second parameter in the constructor.

```jldoctest datesinteg
julia> DateTime(GST(967, 432000), UTC)
2018-03-08T23:59:42

julia> DateTime(GPST(0, 0), UTC)
1980-01-06T00:00:00
```

Please note that the conversion with UTC from a `Date` to a `SystemTime` is not
supported in the sense that a day is a concept independent of UTC.

Also, no guarantees for correct UTC time conversion are made for `DateTime`s
before the origin of GPST.
