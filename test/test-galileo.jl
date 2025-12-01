@testset "Galileo Time" begin
    # DateTime 2025-07-18 -> 37 seconds between TAI and UTC
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    t_tai = t_utc + Second(37)
    d_utc = DateTime(2025, 07, 18)
    d_tai = d_utc + Second(37)
    wn_gnss = 2375
    wn_gal = 2375 - GAL_WEEK_OFFSET
    tow_gnss = 496170
    t_gnss = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(t_utc)
    t_gst = GST(wn_gal, tow_gnss, 0.0)
    t_gstc = GST(wn_gal, tow_gnss)
    t_gst_rollover = GST(wn_gal + GAL_WEEK_NUMBER_ROLLOVER, tow_gnss, 0.0)
    t_gstc_rollover = GST(wn_gal + GAL_WEEK_NUMBER_ROLLOVER, tow_gnss)
    @test t_gst === GST(wn_gal, tow_gnss, 0.0)
    @test t_gst === GST(wn_gal, tow_gnss + 0.0)
    @test t_gstc === GST(wn_gal, tow_gnss)
    @test t_gnss === t_gst
    @test t_gnssc === t_gstc
    @test wntow(GST, t_gst) === (wn_gal, tow_gnss)
    @test wntow(GST, t_gstc) === (wn_gal, tow_gnss)
    @test wntow(GST, t_gst_rollover, true) === (wn_gal % GAL_WEEK_NUMBER_ROLLOVER, tow_gnss)
    @test wntow(GST, t_gstc_rollover, true) === (wn_gal % GAL_WEEK_NUMBER_ROLLOVER, tow_gnss)
end
