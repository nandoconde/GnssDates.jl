using GnssDates: SECONDS_IN_WEEK, GnssTime, FineTime, SystemTime, GPST₀, CoarseTimeDelta
using Dates: Hour, Second, UTC

@testset "GnssTime type" begin
    @test GnssTime <: FineTime
    @test GnssTime <: SystemTime
    # TODO Test GnssTime docs
end

@testset "GnssTime constructors" begin
    # acceptable values, but automatic type conversion
    wn = UInt16(1991)
    tow = Float64(441600)
    towf = Float32(0.75)
    # domain errors
    wn1 = -1
    tow1 = SECONDS_IN_WEEK
    towf1 = 1.5
    tow2 = -1
    towf2 = -1.5
    gnsst0 = GnssTime(wn, tow, towf)
    gnsst1 = GnssTime(wn1, tow1, towf1)
    # construct GnssTime
    @test gnsst0.wn == wn
    @test gnsst0.tow_int == tow
    @test gnsst0.tow_frac == towf
    @test gnsst1.wn == wn1 + 1
    @test gnsst1.tow_int == tow1 - SECONDS_IN_WEEK + 1
    @test gnsst1.tow_frac == towf1 - 1
end

@testset "GnssTime canonicalization" begin
    wn = 0
    tow = SECONDS_IN_WEEK
    towf = 1.5
    gnsst0 = GnssTime(wn, tow, towf)
    gnsst1 = GnssTime(-1, tow, towf)
    # test correct canonicalization
    @test gnsst0 == GnssTime(1, 1, 0.5)
    @test gnsst1 == GnssTime(0, 1, 0.5)
end

@testset "GnssTime to/from {Date, DateTime} (via Base.convert)" begin
    gnsst = GnssTime(1991, 432000, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    @test Base.convert(GnssTime, datetime) == gnsst
    @test Base.convert(GnssTime, date) == gnsst
    @test Base.convert(DateTime, gnsst) == datetime
    @test Base.convert(Date, gnsst) == date
end

@testset "GnssTime convenience constructors" begin
    wn = 0
    tow = SECONDS_IN_WEEK
    towf = 1.5
    gnsst = GnssTime(wn, tow, towf)
    @test GnssTime(gnsst) == GnssTime(1, 1, 0.5)
    @test GnssTime(gnsst) == gnsst
    @test GnssTime(wn, tow, towf) == gnsst
end

@testset "GnssTime -> {Date, DateTime} convenience conversion" begin
    gnsst0 = GnssTime(1991, 432000, 0.0)
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    gnsst1 = GnssTime(0, -3600, 0.0)
    @test DateTime(gnsst0) == datetime
    @test Date(gnsst0) == date
    @test DateTime(gnsst1) == (GPST₀ - Hour(1))
end

@testset "GnssTime <- {Date, DateTime} convenience conversion" begin
    date = Date(2018, 3, 9)
    datetime = DateTime(2018, 3, 9)
    gnsst = GnssTime(1991, 432000, 0.0)
    datetime_ = GPST₀ - Hour(1)
    delta_hour = CoarseTimeDelta(0, 3600)
    delta_day = CoarseTimeDelta(0, 24 * 3600)
    @test GnssTime(date) == gnsst
    @test GnssTime(datetime) == gnsst
    @test GnssTime(datetime_) + delta_hour == GnssTime(0, 0, 0.0)
    @test GnssTime(Date(datetime_)) + delta_day == GnssTime(0, 0, 0.0)
end

@testset "GnssTime to/from UTC DateTime" begin
    gnsst = GnssTime(2340, 345600, 0.0)
    dt = DateTime(2024, 11, 14, 0, 0, 0)
    dt_utc = dt - Second(18)
    @test DateTime(gnsst, UTC) == dt_utc
    @test GnssTime(dt_utc, UTC) == gnsst
    @test Date(gnsst, UTC) == Date(dt_utc)
end
