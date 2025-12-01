@testset "WN & TOW retrieval in `AbstractGnssTime`" begin
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    @test wntow(GnssTime, t_utc) === (wn_gnss, tow_gnss)
    @test wntow(GnssTimeCoarse, t_utc) === (wn_gnss, tow_gnss)
end

@testset "Conversion from/to `AbstractGnssTime`" begin
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    wn_gnss = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    @test Base.convert(GnssTime, t_utc) === t_gnss
    @test Base.convert(GnssTimeCoarse, t_utc) === t_gnssc
    @test Base.convert(DateTime, t_gnss) == t_utc
    @test Base.convert(DateTime, t_gnssc) == t_utc
    @test GnssTime(t_utc) === t_gnss
    @test GnssTimeCoarse(t_utc) === t_gnssc
    @test DateTime(t_gnss) == t_utc
    @test DateTime(t_gnssc) == t_utc
end
