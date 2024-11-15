# ==========================================================================================
# comparison
# ==========================================================================================
Base.:(==)(a::GnssTime, b::GnssTime) = Dates.canonicalize(a) === Dates.canonicalize(b)
function Base.:(==)(a::CoarseTime, b::CoarseTime)
    typeof(a) == typeof(b) && return a === b
    return Base.convert(GnssTime, a) == Base.convert(GnssTime, b)
end
Base.:(==)(a::GnssTime, b::CoarseTime) = a == Base.convert(GnssTime, b)
Base.:(==)(a::CoarseTime, b::GnssTime) = b == a


# ==========================================================================================
# addition
# ==========================================================================================
# bottom calls
Base.:(+)(a::TimeDelta, b::SystemTime) = b + a

# coarse addition [inner sum] (time + delta)
function Base.:(+)(a::T, b::CoarseTimeDelta) where {T <: CoarseTime}
    return Dates.canonicalize(T(a.wn + b.weeks, a.tow + b.seconds, Unchecked()))
end
function Base.:(+)(a::GnssTime, b::CoarseTimeDelta)
    gnsst = GnssTime(a.wn + b.weeks, a.tow_int + b.seconds, 0.0, Unchecked())
    return Dates.canonicalize(gnsst)
end

# coarse addition [inner sum] (delta + delta)
function Base.:(+)(a::CoarseTimeDelta, b::CoarseTimeDelta)
    return CoarseTimeDelta(a.weeks + b.weeks, a.seconds + b.seconds)
end

# coarse/fine addition [outer sum] (time + delta)
function Base.:(+)(a::T, b::FineTimeDelta) where {T <: CoarseTime}
    t_unchecked = T(a.wn + b.weeks, a.tow + b.seconds, b.seconds_frac, Unchecked())
    return Dates.canonicalize(t_unchecked)
end

# coarse/fine addition [outer sum] (delta + delta)
function Base.:(+)(a::CoarseTimeDelta, b::FineTimeDelta)
    weeks = a.weeks + b.weeks
    seconds = a.seconds + b.seconds
    return Dates.canonicalize(FineTimeDelta(weeks, seconds, b.seconds_frac))
end

# fine addition [inner sum]


# ==========================================================================================
# subtraction
# ==========================================================================================
function Base.:(-)(a::GnssTime, b::GnssTime)
    return Dates.canonicalize(
        FineTimeDelta(a.wn - b.wn, a.tow_int - b.tow_int, a.tow_frac - b.tow_frac),
    )
end
Base.:(-)(a::CoarseTime, b::GnssTime) = GnssTime(a) - b
Base.:(-)(a::GnssTime, b::CoarseTime) = a - GnssTime(b)
function Base.:(-)(a::T, b::T) where {T <: CoarseTime}
    return Dates.canonicalize(CoarseTimeDelta(a.wn - b.wn, a.tow - b.tow))
end
function Base.:(-)(a::CoarseTime, b::CoarseTime)
    return Dates.canonicalize(CoarseTimeDelta(GnssTime(a) - GnssTime(b)))
end
function Base.:(-)(a::GnssTime, b::FineTimeDelta)
    d = GnssTime_(a.wn - b.wn, a.tow_int - b.tow_int, a.tow_frac - b.tow_frac)
    return Dates.canonicalize(d)
end
Base.:(-)(a::SystemTime, b) = Base.convert(GnssTime, a) - b
function Base.:(-)(a::T, b::CoarseTimeDelta) where {T <: CoarseTime}
    return Dates.canonicalize(T(a.wn - b.weeks, a.tow - b.seconds))
end
