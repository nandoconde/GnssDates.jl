using GnssDates: GnssTime, GST, GPST, SECONDS_IN_WEEK, GAL_WEEK_OFFSET


# ==========================================================================================
# comparison
# ==========================================================================================
@testset "GnssTime equality" begin
    # nominal
    gnsst0 = GnssTime(1991, 432000, 0.0)
    gnsst1 = GnssTime(1991, 432000, 0.0)
    @test gnsst0 == gnsst1
    # canonicalize first
    gnsst2 = GnssTime(1990, 432000 + SECONDS_IN_WEEK, 0.0)
    gnsst3 = GnssTime(1991, 431998, 2.0)
    @test gnsst0 == gnsst2
    @test gnsst0 == gnsst3
    # test inequality
    @test gnsst0 != GnssTime(1991, 431999, 1.5)
end

@testset "CoarseTime to SystemTime equality" begin
    # nominal GST, GPST, self and crossed equality
    gnsst0 = GnssTime(1991, 432000, 0.0)
    gst0 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gst1 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst0 = GPST(1991, 432000)
    gpst1 = GPST(1991, 432000)
    @test gst0 == gst1
    @test gpst0 == gpst1
    @test gst0 == gpst0
    @test gst0 == gnsst0
    # canonicalize first, self and crossed
    gnsst2 = GnssTime(1990, 432000 + SECONDS_IN_WEEK, 0.0)
    gst2 = GST(1990 - GAL_WEEK_OFFSET, 432000 + SECONDS_IN_WEEK)
    gpst2 = GPST(1990, 432000 + SECONDS_IN_WEEK)
    @test gst0 == gst2
    @test gpst0 == gpst2
    @test gst2 == gpst2
    @test gst2 == gnsst2
    @test gnsst2 == gpst2
    # test inequality, self and crossed
    @test gst0 != GST(1991 - GAL_WEEK_OFFSET, 431999)
    @test gpst0 != GPST(1991, 431999)
    @test gpst0 != GnssTime(1991, 431999, 1.5)
    @test GnssTime(1991, 431999, 1.5) != gst0
end

@testset "SystemTime order" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst = GPST(1991, 432001)
    gnsst = GnssTime(1991, 432000, 0.25)
    @test gst < gpst
    @test !(gst < gst)
    @test gnsst < gpst
    @test gst < gnsst
    @test !(gnsst < gnsst)
    @test gpst > gst
    @test gpst > gnsst
    @test gnsst > gst
    @test gst <= gst
    @test gst <= gnsst
    @test gnsst <= gnsst
    @test gnsst <= gpst
    @test gpst >= gpst
    @test gnsst >= gnsst
    @test gpst >= gnsst
    @test gnsst >= gst
end

@testset "DeltaTime equality" begin
    # self, coarse
    ctd1 = CoarseTimeDelta(4, 197)  
    ctd2 = CoarseTimeDelta(4, 198)
    @test ctd1 == ctd1
    @test ctd1 != ctd2
    # self, fine
    ftd1 = FineTimeDelta(4, 197, 0.0)
    ftd2 = FineTimeDelta(4, 197, 0.5)
    @test ftd1 == ftd1
    @test ftd1 != ftd2
    # cross
    @test ctd1 == ftd1
    # canonicalization
    @test ctd1 == CoarseTimeDelta(3, 197 + SECONDS_IN_WEEK)
    @test ftd1 == FineTimeDelta(3, 196 + SECONDS_IN_WEEK, 1.0)
end

@testset "DeltaTime isless" begin
    # self, coarse
    ctd1 = CoarseTimeDelta(4, 197)  
    ctd2 = CoarseTimeDelta(4, 198)
    @test ctd1 < ctd2
    @test ctd2 > ctd1
    @test ctd1 <= ctd1
    @test ctd1 >= ctd1
    # self, fine
    ftd1 = FineTimeDelta(4, 197, 0.0)
    ftd2 = FineTimeDelta(4, 197, 0.5)
    @test ftd1 < ftd2
    @test ftd2 > ftd1
    @test ftd1 <= ftd1
    @test ftd1 >= ftd1
    # cross
    @test ctd1 < ftd2
    @test ftd1 < ctd2
    @test ctd2 > ftd1
    @test ftd2 > ctd1
    @test ctd1 <= ftd1
    @test ftd1 <= ctd1
    @test ctd1 >= ftd1
    @test ftd1 >= ctd1   
end


# ==========================================================================================
# addition
# ==========================================================================================
@testset "SystemTime + SystemTime" begin
    # nominal
    gst0 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst0 = GPST(1991, 432000)
    gnsst0 = GnssTime(1991, 432000, 0.0)
    # method errors, cannot sum times
    @test_throws MethodError gst0 + gpst0
    @test_throws MethodError gst0 + gnsst0
    @test_throws MethodError gnsst0 + gst0
    @test_throws MethodError gnsst0 + gnsst0
end

@testset "SystemTime + CoarseTimeDelta" begin
    # nominal
    gst0 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst0 = GPST(1991, 432000)
    gnsst0 = GnssTime(1991, 432000, 0.0)
    res0 = GPST(1992, 432010)
    delta0 = CoarseTimeDelta(1, 10)
    @test gst0 + delta0 == res0
    @test gpst0 + delta0 == res0
    @test delta0 + gst0 == res0
    @test gnsst0 + delta0 == GnssTime(res0)
    # overflow
    gpst1 = GPST(1991, SECONDS_IN_WEEK - 1)
    gst1 = GST(gpst1)
    gnsst1 = GnssTime(gpst1)
    delta1 = CoarseTimeDelta(1, 2)
    res1 = GPST(1993, 1)
    @test gst1 + delta1 == res1
    @test gpst1 + delta1 == res1
    @test gnsst1 + delta1 == res1
end

@testset "SystemTime + FineTimeDelta" begin
    # nominal
    gst0 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst0 = GPST(1991, 432000)
    gnsst0 = GnssTime(1991, 432000, 0.0)
    res0 = GnssTime(1992, 432010, 0.5)
    delta0 = FineTimeDelta(1, 10, 0.5)
    @test gst0 + delta0 == res0
    @test gpst0 + delta0 == res0
    @test delta0 + gst0 == res0
    @test gnsst0 + delta0 == GnssTime(res0)
    # overflow
    gpst1 = GPST(1991, SECONDS_IN_WEEK - 1)
    gst1 = GST(gpst1)
    gnsst1 = GnssTime(gpst1)
    delta1 = FineTimeDelta(1, 2, 0.5)
    res1 = GnssTime(1993, 1, 0.5)
    @test gst1 + delta1 == res1
    @test gpst1 + delta1 == res1
    @test gnsst1 + delta1 == res1
end

@testset "TimeDelta + TimeDelta" begin
    # coarse, positive, negative and overflow
    ctd1 = CoarseTimeDelta(-3, 400)
    ctd2 = CoarseTimeDelta(3, SECONDS_IN_WEEK - 400)
    @test ctd1 + ctd2 == CoarseTimeDelta(1, 0)
    # fine, positive, negative and overflow
    ftd1 = FineTimeDelta(-3, 400, 0.75)
    ftd2 = FineTimeDelta(3, SECONDS_IN_WEEK - 400, 0.25)
    @test ftd1 + ftd2 == FineTimeDelta(1, 1, 0.0)
    # cross sum, positive, negative and overflow
    @test ctd1 + ftd2 == FineTimeDelta(1, 0, 0.25)
    @test ftd1 + ctd2 == FineTimeDelta(1, 0, 0.75)
end


# ==========================================================================================
# subtraction
# ==========================================================================================
@testset "TimeDelta - SystemTime" begin
    gst0 = GST(1991 - GAL_WEEK_OFFSET + 1, 432010)
    gpst0 = GPST(gst0)
    gnsst0 = GnssTime(gst0)
    delta0 = CoarseTimeDelta(1, 10)
    # method errors, cannot sum times
    @test_throws MethodError delta0 - gpst0
    @test_throws MethodError delta0 - gnsst0
end

@testset "SystemTime - CoarseTimeDelta" begin
    # nominal
    gst0 = GST(1991 - GAL_WEEK_OFFSET + 1, 432010)
    gpst0 = GPST(gst0)
    gnsst0 = GnssTime(gst0)
    res0 = GST(1991 - GAL_WEEK_OFFSET, 432000)
    delta0 = CoarseTimeDelta(1, 10)
    @test gst0 - delta0 == res0
    @test gpst0 - delta0 == res0
    @test gnsst0 - delta0 == GnssTime(res0)
    # underflow
    gpst1 = GPST(1993, 1)
    gst1 = GST(gpst1)
    gnsst1 = GnssTime(gpst1)
    delta1 = CoarseTimeDelta(1, 2)
    res1 = GPST(1991, SECONDS_IN_WEEK - 1)
    @test gst1 - delta1 == res1
    @test gpst1 - delta1 == res1
    @test gnsst1 - delta1 == res1
end

@testset "SystemTime - FineTimeDelta" begin
    # nominal
    gst0 = GST(1992 - GAL_WEEK_OFFSET, 432011)
    gpst0 = GPST(gst0)
    gnsst0 = GnssTime(gst0)
    res0 = GnssTime(1991, 432000, 0.5)
    delta0 = FineTimeDelta(1, 10, 0.5)
    @test gst0 - delta0 == res0
    @test gpst0 - delta0 == res0
    @test gnsst0 - delta0 == GnssTime(res0)
    # underflow
    gpst1 = GPST(1993, 1)
    gst1 = GST(gpst1)
    gnsst1 = GnssTime(gpst1)
    delta1 = FineTimeDelta(1, 2, 0.5)
    res1 = GnssTime(1991, SECONDS_IN_WEEK - 2, 0.5)
    @test gst1 - delta1 == res1
    @test gpst1 - delta1 == res1
    @test gnsst1 - delta1 == res1
end

@testset "TimeDelta - TimeDelta" begin
    # coarse, positive, negative and overflow
    ctd1 = CoarseTimeDelta(-2, 400 - SECONDS_IN_WEEK)
    ctd2 = CoarseTimeDelta(3, SECONDS_IN_WEEK - 400)
    ctd3 = CoarseTimeDelta(1, 0)
    @test ctd3 - ctd2 == ctd1
    # fine, positive, negative and overflow
    ftd1 = FineTimeDelta(-2, 401 - SECONDS_IN_WEEK, -0.25)
    ftd2 = FineTimeDelta(3, SECONDS_IN_WEEK - 400, 0.25)
    ftd3 = FineTimeDelta(1, 1, 0.0)
    @test ftd3 - ftd2 == ftd1
    # cross sum, positive, negative and overflow
    ftd4 = FineTimeDelta(-6, -604000, -0.25)
    @test ctd1 - ftd2 == ftd4
    @test ftd1 - ctd2 == ftd4 + CoarseTimeDelta(0, 1)
end