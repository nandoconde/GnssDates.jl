# ==========================================================================================
# integer scaling
# ==========================================================================================
function Base.:(*)(a::Integer, t::TimeDelta)
    return TimeDelta(a * t.weeks, a * t.seconds, a * t.frac)
end

function Base.:(*)(a::Integer, t::TimeDeltaCoarse)
    return TimeDeltaCoarse(a * t.weeks, a * t.seconds)
end

function Base.:(*)(t::AbstractTimeDelta, a::Integer)
    return a * t
end

function Base.:(-)(t::AbstractTimeDelta)
    return -1 * t
end


# ==========================================================================================
# addition (delta, delta)
# ==========================================================================================
# +(coarse_d, coarse_d) -> coarse_d
function Base.:(+)(a::TimeDeltaCoarse, b::TimeDeltaCoarse)
    return TimeDeltaCoarse(a.weeks + b.weeks, a.seconds + b.seconds)
end

# +(fine_d, fine_d) -> fine_d
function Base.:(+)(a::TimeDelta, b::TimeDelta)
    weeks = a.weeks + b.weeks
    seconds = a.seconds + b.seconds
    sec_frac = a.frac + b.frac
    return TimeDelta(weeks, seconds, sec_frac)
end

# +(coarse_d, fine_d) -> fine_d
function Base.:(+)(a::TimeDeltaCoarse, b::TimeDelta)
    weeks = a.weeks + b.weeks
    seconds = a.seconds + b.seconds
    return TimeDelta(weeks, seconds, b.frac)
end

# +(fine_d, coarse_d) -> fine_d
function Base.:(+)(a::TimeDelta, b::TimeDeltaCoarse)
    return b + a
end


# ==========================================================================================
# addition (time, delta)
# ==========================================================================================
# +(coarse, coarse_d) -> coarse
function Base.:(+)(a::GnssTimeCoarse, b::TimeDeltaCoarse)
    return GnssTimeCoarse(a.wn + b.weeks, a.tow + b.seconds)
end

# +(fine, coarse_d) -> fine
function Base.:(+)(a::GnssTime, b::TimeDeltaCoarse)
    return GnssTime(a.wn + b.weeks, a.tow + b.seconds, a.frac)
end

# +(any, fine_d) -> fine
function Base.:(+)(a::AbstractGnssTime, b::TimeDelta)
    a_ = GnssTime(a)
    return GnssTime(a_.wn + b.weeks, a_.tow + b.seconds, a_.frac + b.frac)
end

# conmutative sum
function Base.:(+)(a::AbstractTimeDelta, b::AbstractGnssTime)
    return b + a
end


# ==========================================================================================
# subtraction
# ==========================================================================================
# -(a, b) -> +(a, -b)
function Base.:(-)(a::AbstractGnssTime, b::AbstractTimeDelta)
    return a + (-b)
end

function Base.:(-)(a::AbstractTimeDelta, b::AbstractTimeDelta)
    return a + (-b)
end

# -(any, fine) -> fine_d
function Base.:(-)(a::AbstractGnssTime, b::GnssTime)
    a_ = GnssTime(a)
    return TimeDelta(a_.wn - b.wn, a_.tow - b.tow, a_.frac - b.frac)
end

# -(fine, coarse) -> fine_d
function Base.:(-)(a::GnssTime, b::GnssTimeCoarse)
    return a - GnssTime(b)
end

# -(coarse, coarse) -> coarse_d
function Base.:(-)(a::GnssTimeCoarse, b::GnssTimeCoarse)
    return TimeDeltaCoarse(a.wn - b.wn, a.tow - b.tow)
end
