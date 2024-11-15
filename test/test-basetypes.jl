@testset "basetypes.jl" begin
    # check exports and documentation of public names
    # TODO
    @test FineTime <: SystemTime
    @test CoarseTime <: SystemTime
    @test GnssTime <: FineTime
    @test GPST <: CoarseTime
    @test GST <: CoarseTime
    @test FineTimeDelta <: TimeDelta
    @test CoarseTimeDelta <: TimeDelta
end
