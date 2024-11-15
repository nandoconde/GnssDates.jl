# ==========================================================================================
# time delta
# ==========================================================================================
# common supertype
abstract type TimeDelta end

# implementations
struct CoarseTimeDelta <: TimeDelta
    weeks::Int
    seconds::Int
end

struct FineTimeDelta <: TimeDelta
    weeks::Int
    seconds::Int
    seconds_frac::Float64
end


# ==========================================================================================
# canonicalization
# ==========================================================================================
"Canonicalize a TimeDelta if constructed unchecked."
Dates.canonicalize(::TimeDelta)

function Dates.canonicalize(d::CoarseTimeDelta)
    # attempt positive region
    dw, s = fldmod(d.seconds, SECONDS_IN_WEEK)
    w = d.weeks + dw

    # check positive region
    w >= 0 && return CoarseTimeDelta(w, s)

    # negative region
    dw, s = divrem(d.seconds - SECONDS_IN_WEEK, SECONDS_IN_WEEK)
    return CoarseTimeDelta(d.weeks + dw + 1, s)
end

function Dates.canonicalize(d::FineTimeDelta)
    # attempt positive region
    ds, s_frac = fldmod(d.seconds_frac, 1.0)
    dw, s_int = fldmod(d.seconds + Int(ds), SECONDS_IN_WEEK)
    w = dw + d.weeks

    # check positive region
    w >= 0 && return FineTimeDelta(w, s_int, s_frac)

    # negative region
    s_frac, ds = modf(d.seconds_frac - 1.0) # fldmod(x, 1.0), but faster & result tuple reversed
    dw, s_int = divrem(d.seconds + Int(ds) + 1 - SECONDS_IN_WEEK, SECONDS_IN_WEEK)
    return FineTimeDelta(d.weeks + dw + 1, s_int, s_frac)
end


# ==========================================================================================
# conversion
# ==========================================================================================
function Base.convert(::Type{CoarseTimeDelta}, d::FineTimeDelta)
    d_norm = Dates.canonicalize(d)
    return CoarseTimeDelta(d_norm.weeks, d_norm.seconds)
end

function Base.convert(::Type{FineTimeDelta}, d::CoarseTimeDelta)
    d_norm = Dates.canonicalize(d)
    return FineTimeDelta(d_norm.weeks, d_norm.seconds, 0.0)
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
CoarseTimeDelta(d::CoarseTimeDelta) = d
FineTimeDelta(d::FineTimeDelta) = d
CoarseTimeDelta(d::FineTimeDelta) = Base.convert(CoarseTimeDelta, d)
FineTimeDelta(d::CoarseTimeDelta) = Base.convert(FineTimeDelta, d)
