@testset "basetypes.jl" begin
    # check exports and documentation of public names
    # TODO
    @test GnssTime <: AbstractGnssTime
    @test GnssTimeCoarse <: AbstractGnssTime
    @test TimeDelta <: AbstractTimeDelta
    @test TimeDeltaCoarse <: AbstractTimeDelta
end
