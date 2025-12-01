# ==========================================================================================
# `AbstractGnssTime`
# ==========================================================================================
# equality
# Base.:(==)(a::GnssTime, b::GnssTime) -> default equality
# Base.:(==)(a::GnssTimeCoarse, b::GnssTimeCoarse) -> default equality
function Base.:(==)(a::GnssTime, b::GnssTimeCoarse)
    # return ifelse(iszero(a.frac), ifelse(a.wn == b.wn, a.tow == b.tow, false), false)
    return a == GnssTime(b)
end

function Base.:(==)(a::GnssTimeCoarse, b::GnssTime)
    return b == a
end

# isless
function Base.isless(a::GnssTime, b::GnssTime)
    return ifelse(a.wn < b.wn, true, ifelse(a.tow < b.tow, true, a.frac < b.frac))
end

function Base.isless(a::GnssTimeCoarse, b::AbstractGnssTime)
    return GnssTime(a) < GnssTime(b)
end

function Base.isless(a::GnssTime, b::GnssTimeCoarse)
    return a < GnssTime(b)
end


# ==========================================================================================
# `AbstractTimeDelta`
# ==========================================================================================
# equality
# Base.:(==)(a::TimeDeltaCoarse, b::TimeDeltaCoarse) -> default equality
# Base.:(==)(a::TimeDelta, b::TimeDelta) -> default equality
function Base.:(==)(a::TimeDelta, b::TimeDeltaCoarse)
    return a == TimeDelta(b)
end

function Base.:(==)(a::TimeDeltaCoarse, b::TimeDelta)
    return b == a
end

# isless
function Base.isless(a::TimeDelta, b::TimeDelta)
    return ifelse(a.weeks < b.weeks, true, ifelse(a.seconds < b.seconds, true, a.frac < b.frac))
end

function Base.isless(a::TimeDeltaCoarse, b::AbstractTimeDelta)
    return TimeDelta(a) < TimeDelta(b)
end

function Base.isless(a::TimeDelta, b::TimeDeltaCoarse)
    return a < TimeDelta(b)
end
