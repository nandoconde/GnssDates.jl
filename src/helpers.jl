# ==========================================================================================
# time reference normalization
# ==========================================================================================
"""
    _canon_coarsetime(wn, tow) -> Tuple{Int,Int}

Normalize a (wn, tow) tuple following that:
- `tow` ∈ [0, `SECONDS_IN_WEEK`)
"""
@inline function _canon_coarsetime(wn::Int, tow::Int)
    # normalize TOW to positive numbers within SECONDS_IN_WEEK
    Δw, tow_ = fldmod(tow, SECONDS_IN_WEEK)
    return wn + Δw, tow_
end


"""
    _canon_finetime(wn, tow, towf) -> Tuple{Int,Int,Float64}

Normalize a (wn, tow, towf) tuple following that:

- `tow` ∈ [0, `SECONDS_IN_WEEK`)
- `towf` ∈ [0.0, 1.0)
"""
@inline function _canon_finetime(wn::Int, tow::Int, towf::Float64)
    # normalize TOW_f to positive numbers within 0.0 and 1.0⁻
    Δtow = floor(towf)
    towf_ = towf - Δtow
    wn_, tow_ = _canon_coarsetime(wn, tow + Int(Δtow))
    return wn_, tow_, towf_
end


# ==========================================================================================
# time interval normalization
# ==========================================================================================
"""
    _canon_coarsedelta(w, s) -> Tuple{Int,Int}

Normalize a (w, s) tuple following that:
- `s` ∈ [0, `SECONDS_IN_WEEK`) if it is a positive interval
- `s` ∈ [0, -`SECONDS_IN_WEEK`) if it is a negative interval
"""
@inline function _canon_coarsedelta(w::Int, s::Int)
    # attempt positive region
    Δw, s_ = fldmod(s, SECONDS_IN_WEEK)
    w_ = w + Δw

    # check positive region
    w_ >= 0 && return (w_, s_)

    # negative region
    Δw, s_ = divrem(s - SECONDS_IN_WEEK, SECONDS_IN_WEEK)
    return (w + Δw + 1, s_)
end


"""
    _canon_finedelta(w, s, sf) -> Tuple{Int,Int}

Normalize a (w, s, sf) tuple following that:
- `s` ∈ [0, `SECONDS_IN_WEEK`) if it is a positive interval
- `s` ∈ [0, -`SECONDS_IN_WEEK`) if it is a negative interval
- `sf` ∈ [0.0, 1.0) if it is a positive interval
- `s` ∈ [0, -1.0) if it is a negative interval
"""
@inline function _canon_finedelta(w::Int, s::Int, sf::Float64)
    # attempt positive region
    Δs, sf_ = fldmod(sf, 1.0)
    Δw, s_ = fldmod(s + Int(Δs), SECONDS_IN_WEEK)
    w_ = w + Δw

    # check positive region
    w_ >= 0 && return (w_, s_, sf_)

    # negative region
    sf_, Δs = modf(sf - 1.0) # fldmod(x, 1.0), but faster & result tuple reversed
    Δw, s_ = divrem(s + Int(Δs) + 1 - SECONDS_IN_WEEK, SECONDS_IN_WEEK)
    return (w + Δw + 1, s_, sf_)
end
