# ==========================================================================================
# supertype
# ==========================================================================================
"""
    AbstractTimeDelta

Parent time for `TimeDelta` and `TimeDeltaCoarse`.

Any children of `AbstractTimeDelta` must have at least the following fields:
- `weeks::Int64`: integer number of weeks in the interval
- `seconds::Int64`: integer number of seconds in the interval
"""
abstract type AbstractTimeDelta end


# ==========================================================================================
# implementations
# ==========================================================================================
"""
    TimeDelta(weeks, seconds, frac)

Time interval with subsecond resolution down to **femtoseconds**.
"""
struct TimeDelta <: AbstractTimeDelta
    weeks::Int
    seconds::Int
    frac::Float64

    function TimeDelta(weeks, seconds, frac)
        weeks_, seconds_, frac_ = _canon_finedelta(Int(weeks), Int(seconds), Float64(frac))
        return new(weeks_, seconds_, frac_)
    end
end


"""
    TimeDeltaCoarse(weeks, seconds)

Time interval with integer-second resolution.
"""
struct TimeDeltaCoarse <: AbstractTimeDelta
    weeks::Int
    seconds::Int

    function TimeDeltaCoarse(weeks, seconds)
        w_, s_ = _canon_coarsedelta(Int(weeks), Int(seconds))
        return new(w_, s_)
    end
end


# ==========================================================================================
# conversion between `AbstractTimeDelta`
# ==========================================================================================
function Base.convert(::Type{TimeDeltaCoarse}, td::TimeDelta)
    # as with integers, convert only when fractional part is zeroa
    iszero(td.frac) || throw(InexactError(:TimeDeltaCoarse, TimeDeltaCoarse, td))
    return TimeDeltaCoarse(td.weeks, td.seconds)
end

function Base.convert(::Type{TimeDelta}, td::TimeDeltaCoarse)
    return TimeDelta(td.weeks, td.seconds, 0.0)
end


# ==========================================================================================
# convenience conversion
# ==========================================================================================
"""
    TimeDelta(t::T)

Convert from a time interval with type `T` to `TimeDelta`.
"""
TimeDelta(d) = Base.convert(TimeDelta, d)

"""
    TimeDeltaCoarse(t::T)

Convert from a time interval with type `T` to `TimeDeltaCoarse`.
"""
TimeDeltaCoarse(d) = Base.convert(TimeDeltaCoarse, d)
