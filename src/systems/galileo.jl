# ==========================================================================================
# generic galileo time
# ==========================================================================================
# TODO Document struct and fields
struct GST <: CoarseTime
    wn::Int
    tow::Int

    function GST(wn, tow)
        wn_, tow_ = _canon_coarsetime(Int(wn), Int(tow))
        return new(wn_, tow_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
# NOTE
#   This discards the fractional part directly without checking first.
function Base.convert(::Type{T}, t::GnssTime) where {T <: GST}
    GST(t.wn - GAL_WEEK_OFFSET, t.tow_int)
end
function Base.convert(::Type{T}, t::GST) where {T <: GnssTime}
    GnssTime(t.wn + GAL_WEEK_OFFSET, t.tow, 0.0)
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
GST(t::Union{Date, DateTime, SystemTime}) = Base.convert(GST, t)

# Convenience conversion (UTC)
GST(t::DateTime, ::Type{UTC}) = GST(GnssTime(t, UTC))
