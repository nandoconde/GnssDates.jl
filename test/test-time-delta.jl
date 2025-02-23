import Dates
import Base

@testset "timedelta.jl (coarse)" begin
    # check exports and documentation of public names
    # TODO
    # nominal
    ctd = CoarseTimeDelta(1991, 441600)
    @test ctd.weeks == 1991
    @test ctd.seconds == 441600
    # overflow, positive
    ctd_op = CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK + 1)
    @test ctd_op == CoarseTimeDelta(1, 1)
    # underflow, positive
    ctd_up = CoarseTimeDelta(1, -1)
    @test ctd_up == CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK - 1)
    # overflow, negative
    ctd_on = CoarseTimeDelta(-1, 1)
    @test ctd_on == CoarseTimeDelta(0, -GnssDates.SECONDS_IN_WEEK + 1)
    # underflow, negative
    ctd_un = CoarseTimeDelta(-3, -GnssDates.SECONDS_IN_WEEK - 1)
    @test ctd_un == CoarseTimeDelta(-4, -1)
end

@testset "timedelta.jl (fine)" begin
    # Fine (nominal and corner cases)
    ftd = FineTimeDelta(1991, 441600, 0.75)
    @test ftd.weeks == 1991
    @test ftd.seconds == 441600
    @test ftd.seconds_frac == 0.75
    # overflow, positive
    ctd_op = CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK + 1)
    @test ctd_op == CoarseTimeDelta(1, 1)
    # underflow, positive
    ctd_up = CoarseTimeDelta(1, -1)
    @test ctd_up == CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK - 1)
    # overflow, negative
    ctd_on = CoarseTimeDelta(-1, 1)
    @test ctd_on == CoarseTimeDelta(0, -GnssDates.SECONDS_IN_WEEK + 1)
    # underflow, negative
    ctd_un = CoarseTimeDelta(-3, -GnssDates.SECONDS_IN_WEEK - 1)
    @test ctd_un == CoarseTimeDelta(-4, -1)
end

@testset "timedelta.jl (conversion)" begin
    ctd = CoarseTimeDelta(1991, 441600)
    ftd = FineTimeDelta(1991, 441600, 0.75)
    @test Base.convert(CoarseTimeDelta, ftd) == ctd
    @test Base.convert(FineTimeDelta, ctd) == FineTimeDelta(1991, 441600, 0.0)
end

@testset "timedelta.jl (convenience constructors)" begin
    ctd = CoarseTimeDelta(1991, 441600)
    ftd = FineTimeDelta(1991, 441600, 0.75)
    ftd_ = FineTimeDelta(1991, 441600, 0.0)
    @test CoarseTimeDelta(ctd) == ctd
    @test CoarseTimeDelta(ftd) == ctd
    @test FineTimeDelta(ctd) == ftd_
    @test FineTimeDelta(ftd) == ftd
end
