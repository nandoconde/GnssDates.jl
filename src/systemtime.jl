# ==========================================================================================
# system time interface
# ==========================================================================================
# abstract supertypes
abstract type SystemTime end

# CoarseTime
#   - wn
#   - tow
abstract type CoarseTime <: SystemTime end

# FineTime
#   - wn
#   - tow_int
#   - tow_frac
abstract type FineTime <: SystemTime end

"Canonicalize a SystemTime if constructed unchecked."
function Dates.canonicalize(::SystemTime) end

"""Convert between two times without time domain checks.

Any `SystemTime` must implement `unchecked_convert` to and from `GnssTime`.
Additionally, GnssTime implements unchecked conversion to `DateTime`.
"""
function unchecked_convert end


# ==========================================================================================
# code loading
# ==========================================================================================
include("systems/gnsstime.jl")
include("systems/galileo.jl")
include("systems/gps.jl")


# ==========================================================================================
# canonicalization (fallback)
# ==========================================================================================
function Dates.canonicalize(t::T) where {T <: CoarseTime}
    Δweeks, tow = fldmod(t.tow, SECONDS_IN_WEEK)
    wn = t.wn + Δweeks
    return T(wn, tow, Unchecked())
    # if wn < 0
    #     throw(DomainError(wn, LazyString(lazy"$(T) cannot be a negative time.")))
    # else
    #     return T(wn, tow, Unchecked())
    # end
end


# ==========================================================================================
# conversion (fallbacks)
# ==========================================================================================
# NOTE type parameters are "over-extracted" so specialization can be done at compile time
#   and the IDE LSP does not complain about not having the appropriate method, but it is not
#   absolutely necessary to do so for some of them.

# unchecked conversion (self)
unchecked_convert(::Type{T}, t::T) where {T <: SystemTime} = t

# between different SystemTime
function Base.convert(::Type{T}, t::SystemTime) where {T <: SystemTime}
    return Dates.canonicalize(unchecked_convert(T, unchecked_convert(GnssTime, t)))
end

# to/from Date and DateTime
function Base.convert(::Type{DT}, t::SystemTime) where {DT <: Union{Date, DateTime}}
    return Base.convert(DT, Base.convert(GnssTime, t))
end
function Base.convert(::Type{T}, t::Union{Date, DateTime}) where {T <: SystemTime}
    return Base.convert(T, Base.convert(GnssTime, t))
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# GnssTime
GnssTime(t::SystemTime) = GnssTime(unchecked_convert(GnssTime, t))
GnssTime(t::SystemTime, ::Unchecked) = GnssTime(unchecked_convert(GnssTime, t))
GnssTime_(t::SystemTime) = GnssTime(t, Unchecked())

# Dates
DateTime(x::SystemTime) = Base.convert(DateTime, x)
Date(x::SystemTime) = Base.convert(Date, x)
DateTime(x::CoarseTime, ::Type{UTC}) = DateTime(Base.convert(GnssTime, x), UTC)
Date(x::CoarseTime, ::Type{UTC}) = Date(Base.convert(GnssTime, x), UTC)
