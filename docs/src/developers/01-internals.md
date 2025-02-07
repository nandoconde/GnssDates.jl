# Internals

Most of the structure of the package can be inferred from the manual.
Implementing new `T <: SystemTime`s requires only adding methods for:

- Constructor: `T(...)`
- Conversion methods:
  - `Base.convert(::Type{T}, t::GnssTime)`
  - `Base.convert(::Type{GnssTime}, t::T)`
- Convenience constructors:
  - `T(t::Union{Date, DateTime, SystemTime})`
  - `T(t::DateTime, ::Type{UTC}) = GST(GnssTime(t, UTC))`
