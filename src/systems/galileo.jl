# ==========================================================================================
# generic galileo time
# ==========================================================================================
# TODO Document struct and fields
struct GST <: CoarseTime
    wn::Int
    tow::Int

    # main constructor
    function GST(wn::Int, tow::Int)
        if wn < 0
            throw(DomainError(wn, "GST cannot have a negative Week Number"))
        elseif tow < 0
            throw(DomainError(tow, "GST cannot have a negative Time of Week"))
        elseif tow >= SECONDS_IN_WEEK
            throw(
                DomainError(
                    tow,
                    "GST cannot have a Time of Week greater than SECONDS_IN_WEEK",
                ),
            )
        else
            return new(wn, tow)
        end
    end

    # unchecked constructor
    GST(wn::Int, tow::Int, ::Unchecked) = new(wn, tow)

end


# ==========================================================================================
# canonicalization
# ==========================================================================================
# unneded, done for all CoarseTime at systemtime.jl


# ==========================================================================================
# conversion
# ==========================================================================================
# unchecked conversion (GnssTime)
function unchecked_convert(::Type{T}, t::GST) where {T <: GnssTime}
    return GnssTime(t.wn + GAL_WEEK_OFFSET, t.tow, 0.0, Unchecked())
end
function unchecked_convert(::Type{T}, t::GnssTime) where {T <: GST}
    # NOTE
    #   This discards the fractional part direclty without checking first.
    return GST(t.wn - GAL_WEEK_OFFSET, t.tow_int, Unchecked())
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# GST (checked)
GST(t::GST) = Dates.canonicalize(t)

# GST (unchecked)
GST(t::GST, ::Unchecked) = t
GST_(t::GST) = t
GST_(wn, tow) = GST(wn, tow, Unchecked())

# Convenience conversion (SystemTime)
GST(t::SystemTime) = Base.convert(GST, t)
GST(t::SystemTime, ::Unchecked) = unchecked_convert(GST, unchecked_convert(GnssTime, t))
GST_(t::SystemTime) = GST(t, Unchecked())

# Convenience conversion (Dates)
GST(t::DateTime) = Base.convert(GST, t)
GST(t::DateTime, ::Unchecked) = GST_(GnssTime_(t))
GST_(t::DateTime) = GST(t, Unchecked())
GST(t::Date) = Base.convert(GST, t)
GST(t::Date, ::Unchecked) = GST_(GnssTime_(t))
GST_(t::Date) = GST(t, Unchecked())

# Convenience conversion (UTC)
#   Other constructors covered in systemtime.jl
GST(t::DateTime, ::Type{UTC}) = GST(GnssTime(t, UTC))
