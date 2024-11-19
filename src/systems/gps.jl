# ==========================================================================================
# generic gps time
# ==========================================================================================
# TODO Document type and fields
struct GPST <: CoarseTime
    wn::Int
    tow::Int

    function GPST(wn, tow)
        wn_, tow_ = _canon_coarsetime(Int(wn), Int(tow))
        return new(wn_, tow_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
# unchecked conversion (GnssTime)
# NOTE
#   This discards the fractional part direclty without checking first.
Base.convert(::Type{T}, t::GnssTime) where {T <: GPST} = GPST(t.wn, t.tow_int)
Base.convert(::Type{T}, t::GPST) where {T <: GnssTime} = GnssTime(t.wn, t.tow, 0.0)    


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
GPST(t::Union{SystemTime, Date, DateTime}) = Base.convert(GPST, t)

# Convenience conversion (UTC)
GPST(t::DateTime, ::Type{UTC}) = GPST(GnssTime(t, UTC))
