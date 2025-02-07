using GnssDates: GST, SECONDS_IN_WEEK, GST₀, GnssTime, GAL_WEEK_OFFSET, GPST
using Dates: Date, DateTime

@testset "GST type" begin
    @test GST <: CoarseTime
    @test GST <: SystemTime
    # TODO Test GnssTime docs
end

@testset "GST constructors" begin
    wn0 = 0
    wn1 = 15
    tow0 = 0
    tow1 = SECONDS_IN_WEEK
    gst0 = GST(wn0, tow0)
    gst1 = GST(wn1, tow1)
    @test gst0.wn == wn0
    @test gst0.tow == tow0
    @test gst1.wn == (wn1 + 1)
    @test gst1.tow == 0
end

@testset "GST convenience constructors" begin
    wn = 0
    tow = SECONDS_IN_WEEK + 1
    towf = 1.5
    gst = GST(wn, tow)
    @test GST(gst) == GST(1, 1)
    @test GST(gst) == gst
    @test GST(wn, tow) == gst
end

@testset "SystemTime -> GST convenience conversion" begin
    gnsst = GnssTime(1991, 432000, 0.0)
    datetime = DateTime(2018, 3, 9)
    gpst = GPST(1991, 432000)
    gst = GST(1991 - GAL_WEEK_OFFSET, 432000)
    # TODO add more systems
    @test GST(gnsst) == gst
    @test GST(gpst) == gst
    # corner cases
    gnsst_ = GnssTime(0, -3600, 0.0)
    gpst_ = GPST(0, -3600)
    delta_weeks = CoarseTimeDelta(GAL_WEEK_OFFSET, 0)
    @test (GST(gnsst_) + CoarseTimeDelta(0, 3600)) + delta_weeks == GST(0, 0)
    @test (GST(gpst_) + CoarseTimeDelta(0, 3600)) + delta_weeks == GST(0, 0)
end

@testset "GST <- {Date, DateTime} convenience conversion" begin
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    gst = GST(1991 - GAL_WEEK_OFFSET, 432000)
    datetime_ = GST₀ - Hour(1)
    delta_hour = CoarseTimeDelta(0, 3600)
    delta_day = CoarseTimeDelta(0, 24 * 3600)
    # nominal
    @test GST(date) == gst
    @test GST(datetime) == gst
    # corner cases
    @test GST(datetime_) + delta_hour == GST(0, 0)
    @test GST(Date(datetime_)) + delta_day == GST(0, 0)
end

@testset "GST to/from UTC DateTime" begin
    gst = GST(2340 - GAL_WEEK_OFFSET, 345600)
    dt = DateTime(2024, 11, 14, 0, 0, 0)
    dt_utc = dt - Second(18)
    @test GST(dt_utc, UTC) == gst
    @test DateTime(gst, UTC) == dt_utc
    @test Date(gst, UTC) == Date(dt_utc)
end
