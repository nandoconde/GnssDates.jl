@testset "GnssTime constructors" begin
    # setup
    w = 653
    s = 238743
    f = 0.0
    td_0 = TimeDelta(w, s, 0.0)
    td_1 = TimeDelta(w + 1, s + 1, f)
    tdc_0 = TimeDeltaCoarse(w, s)
    tdc_1 = TimeDeltaCoarse(w + 1, s + 1)
    # test
    @test td_0 === TimeDelta(Int16(w), Int32(s), Float16(f))
    @test td_1 === TimeDelta(w, s + SECONDS_IN_WEEK, f + 1)
    @test tdc_0 === TimeDeltaCoarse(Int16(w), Int32(s))
    @test tdc_1 === TimeDeltaCoarse(w, s + SECONDS_IN_WEEK + 1)
end

@testset "GnssTime to/from GnssTimeCoarse" begin
    # setup
    w = 653
    s = 238743
    f = 0.5
    td_0 = TimeDelta(w, s, 0.0)
    tdc_0 = TimeDeltaCoarse(w, s)
    @test Base.convert(TimeDeltaCoarse, td_0) === tdc_0
    @test Base.convert(TimeDelta, tdc_0) === td_0
    @test TimeDelta(tdc_0) === td_0
    @test TimeDeltaCoarse(td_0) === tdc_0
end
