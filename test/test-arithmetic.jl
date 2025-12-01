@testset "·(integer, delta)" begin
    # setup
    w = 653
    s = 238743
    f = 0.75
    X = rand(Int16)
    td = TimeDelta(w, s, f)
    tdc = TimeDeltaCoarse(w, s)
    xtd = TimeDelta(X * w, X * s, X * f)
    xtdc = TimeDeltaCoarse(X * w, X * s)
    mtd = TimeDelta(-w, -s, -f)
    mtdc = TimeDeltaCoarse(-w, -s)
    # test
    @test X * td === xtd
    @test X * tdc === xtdc
    @test td * X === xtd
    @test tdc * X === xtdc
    @test mtd === -td
    @test mtdc === -tdc
end

@testset "+(delta, delta)" begin
    # setup
    w = 653
    s = 238743
    f = 0.5
    td = TimeDelta(w, s, f)
    tdc = TimeDeltaCoarse(w, s)
    # test
    @test (td + td) === 2 * td
    @test (tdc + tdc) === 2 * tdc
    @test (td + tdc) === (tdc + td)
end

@testset "+(time, delta)" begin
    # setup
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    w = 653
    s = 238743
    f = 0.5
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    td = TimeDelta(w, s, f)
    tdc = TimeDeltaCoarse(w, s)
    # test
    @test (t_gnssc + tdc) === GnssTimeCoarse(wn_gnss + w, tow_gnss + s)
    @test (tdc + t_gnssc) === GnssTimeCoarse(wn_gnss + w, tow_gnss + s)
    @test (t_gnss + tdc) === GnssTime(wn_gnss + w, tow_gnss + s, 0.0)
    @test (tdc + t_gnss) === GnssTime(wn_gnss + w, tow_gnss + s, 0.0)
    @test (t_gnss + td) === GnssTime(wn_gnss + w, tow_gnss + s, f)
    @test (td + t_gnss) === GnssTime(wn_gnss + w, tow_gnss + s, f)
    @test (t_gnssc + td) === GnssTime(wn_gnss + w, tow_gnss + s, f)
    @test (td + t_gnssc) === GnssTime(wn_gnss + w, tow_gnss + s, f)
end

@testset "-(a, b) -> +(a, -b)" begin
    # setup
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    w = 653
    s = 238743
    f = 0.5
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    td = TimeDelta(w, s, f)
    tdc = TimeDeltaCoarse(w, s)
    # test
    @test (t_gnssc - tdc) === GnssTimeCoarse(wn_gnss - w, tow_gnss - s)
    @test (t_gnss - tdc) === GnssTime(wn_gnss - w, tow_gnss - s, 0.0)
    @test (t_gnss - td) === GnssTime(wn_gnss - w, tow_gnss - s, -f)
    @test (t_gnssc - td) === GnssTime(wn_gnss - w, tow_gnss - s, -f)
    @test (td - tdc) === TimeDelta(0, 0, f)
    @test (tdc - td) === TimeDelta(0, 0, -f)
    @test (tdc - tdc) === TimeDeltaCoarse(0, 0)
    @test (td - td) === TimeDelta(0, 0, 0)
    @test (t_gnss - t_gnss) === TimeDelta(0, 0, 0)
    @test (t_gnss - t_gnssc) === TimeDelta(0, 0, 0)
    @test (t_gnssc - t_gnssc) === TimeDeltaCoarse(0, 0)
end
