@testset "BeiDou Time" begin
    # DateTime 2025-07-18 -> 37 seconds between TAI and UTC
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    t_tai = t_utc + Second(37)
    d_utc = DateTime(2025, 07, 18)
    d_tai = d_utc + Second(37)
    wn_gnss = 2375
    tow_gnss = 496170
    wn_bds = 2375 - BDS_WEEK_OFFSET
    tow_bds = 496170 - BDS_SECOND_OFFSET
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    t_bdt = BDT(wn_bds, tow_bds, 0.0)
    t_bdtc = BDT(wn_bds, tow_bds)
    t_bdt_rollover = BDT(wn_bds + BDS_WEEK_NUMBER_ROLLOVER, tow_bds, 0.0)
    t_bdtc_rollover = BDT(wn_bds + BDS_WEEK_NUMBER_ROLLOVER, tow_bds)
    @test t_bdt === BDT(wn_bds, tow_bds, 0.0)
    @test t_bdt === BDT(wn_bds, tow_bds + 0.0)
    @test t_bdtc === BDT(wn_bds, tow_bds)
    @test t_gnss === t_bdt
    @test t_gnssc === t_bdtc
    @test wntow(BDT, t_bdt) === (wn_bds, tow_bds)
    @test wntow(BDT, t_bdtc) === (wn_bds, tow_bds)
    @test wntow(BDT, t_bdt_rollover, true) === (wn_bds % BDS_WEEK_NUMBER_ROLLOVER, tow_bds)
    @test wntow(BDT, t_bdtc_rollover, true) === (wn_bds % BDS_WEEK_NUMBER_ROLLOVER, tow_bds)
end
