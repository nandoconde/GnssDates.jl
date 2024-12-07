using GnssDates
using GnssDates: GAL_WEEK_OFFSET, SECONDS_IN_WEEK, GST₀, GPST₀
using Test
using Dates

# test canonicalization for all CoarseTime
@testset "systemtime.jl (coarse canonicalization)" begin
    gst = GST(966, SECONDS_IN_WEEK - 1)
    gst_ = GST(967, -1)
    gpst = GPST(1990, SECONDS_IN_WEEK - 1)
    gpst_ = GPST(1991, -1)
    @test gst_ == gst
    @test gpst_ == gpst
end

# test CoarseTime -> GnssTime via `Base.convert`
@testset "systemtime.jl (convert to GnssTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.0)
    @test Base.convert(GnssTime, gst) == gnsst
    @test Base.convert(GnssTime, gpst) == gnsst
end

# test SystemTime -> CoarseTime via `Base.convert`
@testset "systemtime.jl (convert to other SystemTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.75)
    @test Base.convert(GST, gnsst) == gst
    @test Base.convert(GST, gpst) == gst
    @test Base.convert(GPST, gnsst) == gpst
    @test Base.convert(GPST, gst) == gpst
end

# test SystemTime  <-> {Date, DateTime} via `Base.convert`
@testset "systemtime.jl (convert to Date and DateTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9, 2, 40, 0)
    @test Base.convert(Date, gnsst) == date
    @test Base.convert(Date, gpst) == date
    @test Base.convert(Date, gst) == date
    @test Base.convert(DateTime, gnsst) == datetime
    @test Base.convert(DateTime, gpst) == datetime
    @test Base.convert(DateTime, gst) == datetime
end

@testset "systemtime.jl (convert from Date and DateTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst = GPST(1991, 432000)
    gnsst = GnssTime(1991, 432000, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    @test Base.convert(GnssTime, datetime) == gnsst
    @test Base.convert(GnssTime, date) == gnsst
    @test Base.convert(GPST, datetime) == gpst
    @test Base.convert(GPST, date) == gpst
    @test Base.convert(GST, datetime) == gst
    @test Base.convert(GST, date) == gst
end

# test CoarseTime -> GnssTime (and unchecked) via convenience constructor
@testset "systemtime.jl (convert to GnssTime via convenience constructor)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.0)
    gst_ = GST(1990 - GAL_WEEK_OFFSET, 441600 + SECONDS_IN_WEEK)
    gpst_ = GPST(1990, 441600 + SECONDS_IN_WEEK)
    # gnsst_ = GnssTime(1990, 441599 + SECONDS_IN_WEEK, 1.0)
    # nominal convert
    @test GnssTime(gpst) == gnsst
    @test GnssTime(gst) == gnsst
    # unchecked nominal constructor
    @test GnssTime(gpst_) == gnsst
    @test GnssTime(gst_) == gnsst
    # shortcut constructor
    @test GnssTime(gpst_) == gnsst
    @test GnssTime(gst_) == gnsst
end

# test SystemTime -> {Date, DateTime} via convenience constructor
@testset "systemtime.jl (convert to Date and DateTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9, 2, 40, 0)
    @test Date(gnsst) == date
    @test Date(gpst) == date
    @test Date(gst) == date
    @test DateTime(gnsst) == datetime
    @test DateTime(gpst) == datetime
    @test DateTime(gst) == datetime
end

# TODO test CoarseTime -> UTC {Date, DateTime} via convenience constructor
@testset "systemtime.jl (convert to UTC Date and DateTime)" begin
    gst = GST(1991 - GAL_WEEK_OFFSET, 441600)
    gpst = GPST(1991, 441600)
    gnsst = GnssTime(1991, 441600, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9, 2, 39, 42)
    @test Date(gnsst, UTC) == date
    @test Date(gpst, UTC) == date
    @test Date(gst, UTC) == date
    @test DateTime(gnsst, UTC) == datetime
    @test DateTime(gpst, UTC) == datetime
    @test DateTime(gst, UTC) == datetime

    # test date rollover
    gst_ = GST(1991 - GAL_WEEK_OFFSET, 432000)
    gpst_ = GPST(1991, 432000)
    gnsst_ = GnssTime(1991, 432000, 0.0)
    date_ = Date(2018, 3, 8)
    datetime_ = DateTime(2018, 3, 8, 23, 59, 42)
    @test Date(gnsst_, UTC) == date_
    @test Date(gpst_, UTC) == date_
    @test Date(gst_, UTC) == date_
    @test DateTime(gnsst_, UTC) == datetime_
    @test DateTime(gpst_, UTC) == datetime_
    @test DateTime(gst_, UTC) == datetime_
end
