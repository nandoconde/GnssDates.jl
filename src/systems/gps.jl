# ==========================================================================================
# generic gps time
# ==========================================================================================
# TODO Document type and fields
struct GPST <: CoarseTime
    wn::Int
    tow::Int

    # main constructor
    function GPST(wn::Int, tow::Int)
        if wn < 0
            throw(DomainError(wn, "GPST cannot have a negative Week Number"))
        elseif tow < 0
            throw(DomainError(tow, "GPST cannot have a negative Time of Week"))
        elseif tow >= SECONDS_IN_WEEK
            throw(
                DomainError(
                    tow,
                    "GPST cannot have a Time of Week greater than SECONDS_IN_WEEK",
                ),
            )
        else
            return new(wn, tow)
        end
    end

    # unchecked constructor
    GPST(wn::Int, tow::Int, ::Unchecked) = new(wn, tow)

end


# ==========================================================================================
# canonicalization
# ==========================================================================================
# unneded, done for all CoarseTime at systemtime.jl


# ==========================================================================================
# conversion
# ==========================================================================================
# unchecked conversion (GnssTime)
function unchecked_convert(::Type{T}, t::GPST) where {T <: GnssTime}
    return GnssTime(t.wn, t.tow, 0.0, Unchecked())
end
function unchecked_convert(::Type{T}, t::GnssTime) where {T <: GPST}
    # NOTE
    #   This discards the fractional part direclty without checking first.
    return GPST(t.wn, t.tow_int, Unchecked())
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# GPST (checked)
GPST(t::GPST) = Dates.canonicalize(t)

# GPST (unchecked)
GPST(t::GPST, ::Unchecked) = t
GPST_(t::GPST) = t
GPST_(wn, tow) = GPST(wn, tow, Unchecked())

# Convenience conversion (SystemTime)
GPST(t::SystemTime) = Base.convert(GPST, t)
GPST(t::SystemTime, ::Unchecked) = unchecked_convert(GPST, unchecked_convert(GnssTime, t))
GPST_(t::SystemTime) = GPST(t, Unchecked())

# Convenience conversion (Dates)
GPST(t::DateTime) = Base.convert(GPST, t)
GPST(t::DateTime, ::Unchecked) = GPST_(GnssTime_(t))
GPST_(t::DateTime) = GPST(t, Unchecked())
GPST(t::Date) = Base.convert(GPST, t)
GPST(t::Date, ::Unchecked) = GPST_(GnssTime_(t))
GPST_(t::Date) = GPST(t, Unchecked())

# Convenience conversion (UTC)
#   Other constructors covered in systemtime.jl
GPST(t::DateTime, ::Type{UTC}) = GPST(GnssTime(t, UTC))
