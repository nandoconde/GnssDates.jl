# ==========================================================================================
# `AbstractGnssTime`
# ==========================================================================================
function Base.round(x::GnssTimeCoarse, ::RoundingMode)
    return x
end

function Base.round(x::GnssTime, r::RoundingMode)
    return GnssTime(x.wn, x.tow, round(x.frac, r))
end


# ==========================================================================================
# `AbstractTimeDelta`
# ==========================================================================================
function Base.round(x::TimeDeltaCoarse, ::RoundingMode)
    return x
end

function Base.round(x::TimeDelta, r::RoundingMode)
    return TimeDelta(x.weeks, x.seconds, round(x.frac, r))
end
