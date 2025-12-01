@testset "GPS Time" begin
    # DateTime 2025-07-18 -> 37 seconds between TAI and UTC
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    t_tai = t_utc + Second(37)
    d_utc = DateTime(2025, 07, 18)
    d_tai = d_utc + Second(37)
    wn_gnss = 2375
    wn_gps = 2375
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    t_gpst = GPST(wn_gps, tow_gnss, 0.0)
    t_gpstc = GPST(wn_gps, tow_gnss)
    t_gpst_rollover = GPST(wn_gps + GPS_WEEK_NUMBER_ROLLOVER, tow_gnss, 0.0)
    t_gpstc_rollover = GPST(wn_gps + GPS_WEEK_NUMBER_ROLLOVER, tow_gnss)
    @test t_gpst === GPST(wn_gps, tow_gnss, 0.0)
    @test t_gpst === GPST(wn_gps, tow_gnss + 0.0)
    @test t_gpstc === GPST(wn_gps, tow_gnss)
    @test t_gnss === t_gpst
    @test t_gnssc === t_gpstc
    @test wntow(GPST, t_gpst) === (wn_gps, tow_gnss)
    @test wntow(GPST, t_gpstc) === (wn_gps, tow_gnss)
    @test wntow(GPST, t_gpst_rollover, true) === (wn_gps % GPS_WEEK_NUMBER_ROLLOVER, tow_gnss)
    @test wntow(GPST, t_gpstc_rollover, true) === (wn_gps % GPS_WEEK_NUMBER_ROLLOVER, tow_gnss)
end
