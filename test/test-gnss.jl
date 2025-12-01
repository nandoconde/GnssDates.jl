@testset "WN & TOW retrieval in `AbstractGnssTime`" begin
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    d_utc = DateTime(2025, 07, 18)
    wn_gnss = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    @test wntow(GnssTime, t_gnss) === (wn_gnss, tow_gnss)
    @test wntow(GnssTime, t_gnss, true) === (wn_gnss, tow_gnss)
    @test wntow(GnssTime, t_gnssc, true) === (wn_gnss, tow_gnss)
    @test wntow(GnssTimeCoarse, t_gnss, true) === (wn_gnss, tow_gnss)
    @test wntow(GnssTimeCoarse, t_gnssc, true) === (wn_gnss, tow_gnss)
end

@testset "GnssTime constructors" begin
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    d_utc = DateTime(2025, 07, 18)
    wn_gnss = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)

    # construct GnssTime
    @test_throws InexactError GnssTime(1.1, 5, 5)
    @test_throws InexactError GnssTime(1, 5.1, 5)
    @test t_gnss === GnssTime(UInt16(wn_gnss), 496170, 0.0)
    @test t_gnss === GnssTime(UInt16(wn_gnss), Float32(496170))
    @test t_gnssc === GnssTimeCoarse(UInt16(wn_gnss), Float32(496170))
    @test t_gnss.wn == wn_gnss
    @test t_gnss.tow == tow_gnss
    @test t_gnss.frac == 0.0
    @test t_gnssc.wn == wn_gnss
    @test t_gnssc.tow == tow_gnss
end

@testset "GnssTime to/from GnssTimeCoarse" begin
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    d_utc = DateTime(2025, 07, 18)
    wn_gnss = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    @test Base.convert(GnssTimeCoarse, t_gnss) === t_gnssc
    @test Base.convert(GnssTime, t_gnssc) === t_gnss
    @test GnssTime(t_gnssc) === t_gnss
    @test GnssTimeCoarse(t_gnss) === t_gnssc
end
