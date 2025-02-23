# ==========================================================================================
# supertype
# ==========================================================================================
"Abstract supertype for all time intervals."
abstract type TimeDelta end


# ==========================================================================================
# implementations
# ==========================================================================================

"""
    CoarseTimeDelta(weeks, seconds)

Time interval with integer-second resolution.

The constructor can convert automatically from other date and datetime types.
"""
struct CoarseTimeDelta <: TimeDelta
    weeks::Int
    seconds::Int

    function CoarseTimeDelta(weeks, seconds)
        w_, s_ = _canon_coarsedelta(Int(weeks), Int(seconds))
        return new(w_, s_)
    end
end

"""
    FineTimeDelta(weeks, seconds, seconds_frac)

Time interval with subsecond resolution.

The constructor can convert automatically from other date and datetime types.
"""
struct FineTimeDelta <: TimeDelta
    weeks::Int
    seconds::Int
    seconds_frac::Float64

    function FineTimeDelta(weeks, seconds, seconds_frac)
        w_, s_, sf_ = _canon_finedelta(Int(weeks), Int(seconds), Float64(seconds_frac))
        return new(w_, s_, sf_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
Base.convert(::Type{T}, td::T) where {T <: TimeDelta} = td
function Base.convert(::Type{T}, td::FineTimeDelta) where {T <: CoarseTimeDelta}
    return CoarseTimeDelta(td.weeks, td.seconds)
end

function Base.convert(::Type{T}, td::CoarseTimeDelta) where {T <: FineTimeDelta}
    return FineTimeDelta(td.weeks, td.seconds, 0.0)
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
CoarseTimeDelta(d::TimeDelta) = Base.convert(CoarseTimeDelta, d)
FineTimeDelta(d::TimeDelta) = Base.convert(FineTimeDelta, d)
