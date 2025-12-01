@testset "GLONASS Time" begin
    # DateTime 2025-07-18 -> 37 seconds between TAI and UTC
    t_utc = DateTime(2025, 07, 18, 17, 49, 12)
    d_utc = DateTime(2025, 07, 18)
    wn_gnss = 2375
    tow_gnss = 496170
    t_moskva = t_utc + Hour(3)
    t_gnss = GnssTime(wn_gnss, Float64(tow_gnss))
    t_gnssh = GnssTime(t_utc)
    t_gnssc = GnssTimeCoarse(wn_gnss, tow_gnss)
    t_glonasst = GLONASST(t_moskva)
    @test t_glonasst === GLONASST(t_moskva)
    @test t_gnss === t_glonasst
    @test t_gnss === t_gnssh
end
