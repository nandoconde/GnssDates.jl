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


# ==========================================================================================
# code loading
# ==========================================================================================
include("systems/gnsstime.jl")
include("systems/galileo.jl")
include("systems/gps.jl")


# ==========================================================================================
# conversion (fallbacks)
# ==========================================================================================
# NOTE type parameters are "over-extracted" so specialization can be done at compile time
#   and the IDE LSP does not complain about not having the appropriate method, but it is not
#   absolutely necessary to do so for some of them.

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
