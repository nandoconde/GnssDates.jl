using GnssDates: GPST, SECONDS_IN_WEEK, GPST₀, GnssTime, GAL_WEEK_OFFSET, GST
using Dates: Date, DateTime

@testset "GPST type" begin
    @test GPST <: CoarseTime
    @test GPST <: SystemTime
    # TODO Test GnssTime docs
end

@testset "GPST constructors" begin
    wn0 = 0
    wn1 = 15
    tow0 = 0
    tow1 = SECONDS_IN_WEEK
    gpst0 = GPST(wn0, tow0)
    gpst1 = GPST(wn1, tow1)
    @test gpst0.wn == wn0
    @test gpst0.tow == tow0
    @test gpst1.wn == wn1 + 1
    @test gpst1.tow == 0
end

@testset "GPST convenience constructors" begin
    wn = 0
    tow = SECONDS_IN_WEEK + 1
    towf = 1.5
    gpst = GPST(wn, tow)
    @test GPST(gpst) == GPST(1, 1)
    @test GPST(gpst) == gpst
end

@testset "SystemTime -> GPST convenience conversion" begin
    gnsst = GnssTime(1991, 432000, 0.0)
    datetime = DateTime(2018, 3, 9)
    gpst = GPST(1991, 432000)
    gst = GST(1991 - GAL_WEEK_OFFSET, 432000)
    # TODO add more systems
    @test GPST(gnsst) == gpst
    @test GPST(gst) == gpst
    # corner cases
    gnsst_ = GnssTime(0, -3600, 0.0)
    gst_ = GST(-GAL_WEEK_OFFSET, -3600)
    @test (GPST(gnsst_) + CoarseTimeDelta(0, 3600)) == GPST(0, 0)
    @test (GPST(gst_) + CoarseTimeDelta(0, 3600)) == GPST(0, 0)
end

@testset "GPST <- {Date, DateTime} convenience conversion" begin
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    gpst = GPST(1991, 432000)
    datetime_ = GPST₀ - Hour(1)
    delta_hour = CoarseTimeDelta(0, 3600)
    delta_day = CoarseTimeDelta(0, 24 * 3600)
    # nominal
    @test GPST(date) == gpst
    @test GPST(datetime) == gpst
    # corner cases
    @test GPST(datetime_) + delta_hour == GPST(0, 0)
    @test GPST(Date(datetime_)) + delta_day == GPST(0, 0)
end

@testset "GPST to/from UTC DateTime" begin
    gpst = GPST(2340, 345600)
    dt = DateTime(2024, 11, 14, 0, 0, 0)
    dt_utc = dt - Second(18)
    @test GPST(dt_utc, UTC) == gpst
    @test DateTime(gpst, UTC) == dt_utc
    @test Date(gpst, UTC) == Date(dt_utc)
end
