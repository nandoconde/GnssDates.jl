# ==========================================================================================
# supertypes
# ==========================================================================================
"Abstract supertype for all time references."
abstract type SystemTime end


"""
Abstract supertype for all coarse time references.

Coarse time references are characterized for always having two fields:
- `wn::Int64`: integer weeks elapsed since origin of time reference.
- `tow::Int64`: integer seconds elapsed since beginning of week.
"""
abstract type CoarseTime <: SystemTime end


"""
Abstract supertype for all fine time references.

Fine time references are characterized for always having three fields:
- `wn::Int64`: integer weeks elapsed since origin of time reference.
- `tow_int::Int64`: integer seconds elapsed since beginning of week.
- `tow_frac::Int64`: seconds elapsed since `tow_int` as a floating point number.

Currently, the only implementation of a `FineTime` is `GnssTime`.
"""
abstract type FineTime <: SystemTime end


# ==========================================================================================
# code loading
# ==========================================================================================
include("systems/gnsstime.jl")
include("systems/galileo.jl")
include("systems/gps.jl")


# ==========================================================================================
# conversion (fallbacks)
# ==========================================================================================
# NOTE type parameters are "over-extracted" from signatures so specialization can be done at
#   compile time and the IDE LSP does not complain about not having the appropriate method,
#   but it is not absolutely necessary to do so for some of them.

# gnss conversion (self)
Base.convert(::Type{T}, t::T) where {T <: SystemTime} = t

# gnss conversion to a different SystemTime
function Base.convert(::Type{T}, t::SystemTime) where {T <: SystemTime}
    return convert(T, convert(GnssTime, t))
end

# to/from Date and DateTime or
function Base.convert(::Type{T}, t::SystemTime) where {T <: Union{Date, DateTime}}
    return convert(T, convert(GnssTime, t))
end
function Base.convert(::Type{T}, t::Union{Date, DateTime}) where {T <: SystemTime}
    return convert(T, convert(GnssTime, t))
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Dates
DateTime(x::SystemTime) = Base.convert(DateTime, x)
Date(x::SystemTime) = Base.convert(Date, x)
DateTime(x::CoarseTime, ::Type{UTC}) = DateTime(Base.convert(GnssTime, x), UTC)
Date(x::CoarseTime, ::Type{UTC}) = Date(Base.convert(GnssTime, x), UTC)
