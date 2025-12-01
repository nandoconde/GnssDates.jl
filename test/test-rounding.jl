@testset "Rounding in `AbstractGnssTime`" begin
    # setup
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    t_utc_1 = DateTime(2025, 07, 18, 17, 49, 13)
    wn_gnss = 2375
    tow_gnss = 496170
    frac = 0.5
    t_gnss0 = GnssTime(wn_gnss, tow_gnss, frac)
    t_gnssc0 = GnssTimeCoarse(t_utc)
    t_gnss1 = GnssTime(t_utc_1)
    t_gnssc1 = GnssTimeCoarse(t_utc_1)
    @test round(t_gnssc0) === t_gnssc0
    @test round(t_gnssc0, RoundNearestTiesAway) === t_gnssc0
    @test GnssTimeCoarse(round(t_gnss0, RoundDown)) === t_gnssc0
    @test GnssTimeCoarse(round(t_gnss0, RoundUp)) === t_gnssc1
    @test GnssTimeCoarse(floor(t_gnss0)) === t_gnssc0
    @test GnssTimeCoarse(ceil(t_gnss0)) === t_gnssc1
    # default `round` goes to nearest EVEN integer
    @test round(t_gnss0) === GnssTime(wn_gnss, tow_gnss, 0.0)
end


@testset "Rounding in `AbstractTimeDelta" begin
    # setup
    w = 653
    s = 238743
    f = 0.5
    td_0 = TimeDelta(w, s, 0.0)
    td_1 = TimeDelta(w, s, f)
    tdc_0 = TimeDeltaCoarse(w, s)
    tdc_1 = TimeDeltaCoarse(w, s + 1)
    # test
    @test round(tdc_0) === tdc_0
    @test round(tdc_0, RoundUp) === tdc_0
    @test round(td_1) === TimeDelta(tdc_0)
    @test round(td_1, RoundDown) === td_0
end
