@testset "constants.jl" begin
    # check exports and documentation of public names
    # TODO
    # test correctness
    @test GnssDates.SECONDS_IN_WEEK == (60 * 60 * 24 * 7)
    @test GnssDates.GAL_WEEK_OFFSET == 1024
    @test GnssDates.LEAP_SECOND_TAI_OFFSET == 19
    @test GnssDates.GPST₀ == DateTime(GPST(0, 0))
    @test GnssDates.GST₀ == DateTime(GST(0, 0))
end
