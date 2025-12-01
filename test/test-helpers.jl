@testset "GnssTimeCoarse normalization functions" begin
    SIW = SECONDS_IN_WEEK
    # nominal
    @test _canon_coarsetime(1, SIW - 1) == (1, SIW - 1)
    @test _canon_coarsetime(-1, SIW - 1) == (-1, SIW - 1)
    # underflow
    @test _canon_coarsetime(1, -1) == (0, SIW - 1)
    @test _canon_coarsetime(0, -1) == (-1, SIW - 1)
    @test _canon_coarsetime(1, -SIW) == (0, 0)
    @test _canon_coarsetime(1, -SIW - 1) == (-1, SIW - 1)
    @test _canon_coarsetime(-1, -SIW - 1) == (-3, SIW - 1)
    # overflow
    @test _canon_coarsetime(1, SIW) == (2, 0)
    @test _canon_coarsetime(1, SIW + 1) == (2, 1)
    @test _canon_coarsetime(1, 2 * SIW + 1) == (3, 1)
    @test _canon_coarsetime(-1, SIW) == (0, 0)
    @test _canon_coarsetime(-1, SIW + 1) == (0, 1)
    @test _canon_coarsetime(-2, 2 * SIW + 1) == (0, 1)
end

@testset "GnssTime normalization functions" begin
    SIW = SECONDS_IN_WEEK
    SIS = 1.0
    # nominal
    @test _canon_finetime(1, SIW - 1, SIS - 0.5) == (1, SIW - 1, SIS - 0.5)
    @test _canon_finetime(-1, SIW - 1, SIS - 0.5) == (-1, SIW - 1, SIS - 0.5)
    # underflow (int)
    @test _canon_finetime(1, -1, 0.0) == (0, SIW - 1, 0.0)
    @test _canon_finetime(0, -1, 0.0) == (-1, SIW - 1, 0.0)
    @test _canon_finetime(1, -SIW, 0.0) == (0, 0, 0.0)
    @test _canon_finetime(1, -SIW - 1, 0.0) == (-1, SIW - 1, 0.0)
    @test _canon_finetime(-1, -SIW - 1, 0.0) == (-3, SIW - 1, 0.0)
    # underflow (float)
    # TODO
    # overflow (int)
    @test _canon_finetime(1, SIW, 0.0) == (2, 0, 0.0)
    @test _canon_finetime(1, SIW + 1, 0.0) == (2, 1, 0.0)
    @test _canon_finetime(1, 2 * SIW + 1, 0.0) == (3, 1, 0.0)
    @test _canon_finetime(-1, SIW, 0.0) == (0, 0, 0.0)
    @test _canon_finetime(-1, SIW + 1, 0.0) == (0, 1, 0.0)
    @test _canon_finetime(-2, 2 * SIW + 1, 0.0) == (0, 1, 0.0)
    # overflow (float)
    # TODO
end

@testset "AbstractTimeDelta normalization functions" begin
    # TODO
end
