@testset "==(time, time)" begin
    # setup
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    w = 653
    s = 238743
    f = 0.5
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    @test t_gnss == t_gnssc
    @test t_gnssc == t_gnss
end

@testset "<(time, time)" begin
    # setup
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    t_utc_1 = DateTime(2025, 07, 18, 17, 50, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    w = 653
    s = 238743
    f = 0.5
    t_gnss0 = GnssTime(t_utc)
    t_gnssc0 = GnssTimeCoarse(t_utc)
    t_gnss1 = GnssTime(t_utc_1)
    t_gnssc1 = GnssTimeCoarse(t_utc_1)
    @test t_gnss0 < t_gnss1
    @test t_gnssc0 < t_gnssc1
    @test t_gnssc0 < t_gnss1
    @test t_gnss0 < t_gnssc1
end

@testset "==(delta, delta)" begin
    # setup
    w = 653
    s = 238743
    f = 0.0
    td = TimeDelta(w, s, f)
    tdc = TimeDeltaCoarse(w, s)
    # test
    @test td == tdc
    @test tdc == td
end

@testset "==(delta, delta)" begin
    # setup
    w = 653
    s = 238743
    f = 0.5
    td_0 = TimeDelta(w, s, 0.0)
    td_1 = TimeDelta(w, s, f)
    tdc_0 = TimeDeltaCoarse(w, s)
    tdc_1 = TimeDeltaCoarse(w, s + 1)
    # test
    @test td_0 < td_1
    @test tdc_0 < tdc_1
    @test td_0 < tdc_1
    @test tdc_0 < td_1
end
