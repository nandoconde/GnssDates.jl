# ==========================================================================================
# comparison
# ==========================================================================================
# SystemTime equality
Base.:(==)(a::GnssTime, b::GnssTime) = a === b
function Base.:(==)(a::CoarseTime, b::CoarseTime)
    typeof(a) == typeof(b) && return a === b
    return GnssTime(a) == GnssTime(b)
end
Base.:(==)(a::GnssTime, b::CoarseTime) = a == GnssTime(b)
Base.:(==)(a::CoarseTime, b::GnssTime) = b == a

# SystemTime isless
function Base.isless(a::T, b::T) where {T <: CoarseTime}
    return ifelse(a.wn < b.wn, true, a.tow < b.tow)
end
function Base.isless(a::T, b::T) where {T <: GnssTime}
    return ifelse(
        a.wn < b.wn,
        true,
        ifelse(a.tow_int < b.tow_int, true, a.tow_frac < b.tow_frac),
    )
end
function Base.isless(a::S, b::T) where {S <: SystemTime, T <: SystemTime}
    return GnssTime(a) < GnssTime(b)
end

# DeltaTime equality
# Base.:(==)(a::CoarseTimeDelta, b::CoarseTimeDelta) -> default equality
# Base.:(==)(a::FineTimeDelta, b::FineTimeDelta) -> default equality
Base.:(==)(a::FineTimeDelta, b::CoarseTimeDelta) = a == FineTimeDelta(b)
Base.:(==)(a::CoarseTimeDelta, b::FineTimeDelta) = FineTimeDelta(a) == b

# DeltaTime isless
function Base.isless(a::CoarseTimeDelta, b::CoarseTimeDelta)
    return ifelse(a.weeks < b.weeks, true, a.seconds < b.seconds)
end
function Base.isless(a::FineTimeDelta, b::FineTimeDelta)
    return ifelse(
        a.weeks < b.weeks,
        true,
        ifelse(a.seconds < b.seconds, true, a.seconds_frac < b.seconds_frac),
    )
end
Base.isless(a::FineTimeDelta, b::CoarseTimeDelta) = isless(a, FineTimeDelta(b))
Base.isless(a::CoarseTimeDelta, b::FineTimeDelta) = isless(FineTimeDelta(a), b)


# ==========================================================================================
# addition
# ==========================================================================================
# bottom calls
Base.:(+)(a::TimeDelta, b::SystemTime) = b + a

# coarse addition [inner sum] (time + delta)
function Base.:(+)(a::T, b::CoarseTimeDelta) where {T <: CoarseTime}
    return T(a.wn + b.weeks, a.tow + b.seconds)
end
function Base.:(+)(a::GnssTime, b::CoarseTimeDelta)
    return GnssTime(a.wn + b.weeks, a.tow_int + b.seconds, 0.0)
end

# coarse addition [inner sum] (delta + delta)
function Base.:(+)(a::CoarseTimeDelta, b::CoarseTimeDelta)
    return CoarseTimeDelta(a.weeks + b.weeks, a.seconds + b.seconds)
end

# fine addition [inner/outer sum] (time + delta)
function Base.:(+)(a::SystemTime, b::FineTimeDelta)
    a_ = convert(GnssTime, a)
    return GnssTime(a_.wn + b.weeks, a_.tow_int + b.seconds, a_.tow_frac + b.seconds_frac)
end

# coarse/fine addition [outer sum] (delta + delta)
function Base.:(+)(a::CoarseTimeDelta, b::FineTimeDelta)
    weeks = a.weeks + b.weeks
    seconds = a.seconds + b.seconds
    return FineTimeDelta(weeks, seconds, b.seconds_frac)
end
Base.:(+)(a::FineTimeDelta, b::CoarseTimeDelta) = b + a

# fine addition [inner sum] (delta + delta)
function Base.:(+)(a::FineTimeDelta, b::FineTimeDelta)
    weeks = a.weeks + b.weeks
    seconds = a.seconds + b.seconds
    sec_frac = a.seconds_frac + b.seconds_frac
    return FineTimeDelta(weeks, seconds, sec_frac)
end


# ==========================================================================================
# subtraction
# ==========================================================================================
function Base.:(-)(a::GnssTime, b::GnssTime)
    return FineTimeDelta(a.wn - b.wn, a.tow_int - b.tow_int, a.tow_frac - b.tow_frac)
end
Base.:(-)(a::CoarseTime, b::GnssTime) = GnssTime(a) - b
Base.:(-)(a::GnssTime, b::CoarseTime) = a - GnssTime(b)
function Base.:(-)(a::T, b::T) where {T <: CoarseTime}
    return CoarseTimeDelta(a.wn - b.wn, a.tow - b.tow)
end
function Base.:(-)(a::CoarseTime, b::CoarseTime)
    ftd = GnssTime(a) - GnssTime(b)
    return CoarseTimeDelta(ftd.weeks, ftd.seconds)
end
function Base.:(-)(a::GnssTime, b::TimeDelta)
    c = FineTimeDelta(b)
    return GnssTime(a.wn - c.weeks, a.tow_int - c.seconds, a.tow_frac - c.seconds_frac)
end
Base.:(-)(a::CoarseTime, b::FineTimeDelta) = GnssTime(a) - b
function Base.:(-)(a::T, b::CoarseTimeDelta) where {T <: CoarseTime}
    return T(a.wn - b.weeks, a.tow - b.seconds)
end
function Base.:(-)(a::FineTimeDelta, b::FineTimeDelta)
    return FineTimeDelta(
        a.weeks - b.weeks,
        a.seconds - b.seconds,
        a.seconds_frac - b.seconds_frac,
    )
end
Base.:(-)(a::CoarseTimeDelta, b::FineTimeDelta) = FineTimeDelta(a) - b
Base.:(-)(a::FineTimeDelta, b::CoarseTimeDelta) = a - FineTimeDelta(b)
function Base.:(-)(a::CoarseTimeDelta, b::CoarseTimeDelta)
    return CoarseTimeDelta(a.weeks - b.weeks, a.seconds - b.seconds)
end


# ==========================================================================================
# integer scaling
# ==========================================================================================
function Base.:(*)(a::Integer, t::CoarseTimeDelta)
    return CoarseTimeDelta(a * t.weeks, a * t.seconds)
end
function Base.:(*)(a::Integer, t::FineTimeDelta)
    return FineTimeDelta(a * t.weeks, a * t.seconds, a * t.seconds_frac)
end
Base.:(-)(t::CoarseTimeDelta) = -1 * t
Base.:(-)(t::FineTimeDelta) = -1 * t
