using GnssDates
import GnssDates: SECONDS_IN_WEEK
import GnssDates: GPS_WEEK_NUMBER_ROLLOVER
import GnssDates: GAL_WEEK_OFFSET, GAL_WEEK_NUMBER_ROLLOVER
import GnssDates: BDS_WEEK_OFFSET, BDS_SECOND_OFFSET, BDS_WEEK_NUMBER_ROLLOVER
import GnssDates: GPST₀, GNSS_TAI_SECOND_OFFSET
import GnssDates: _canon_coarsetime, _canon_finetime, _canon_coarsedelta, _canon_finedelta
using Test
using Dates

#=
Don't add your tests to runtests.jl. Instead, create files named

    test-title-for-my-test.jl

The file will be automatically included inside a `@testset` with title "Title For My Test".
=#
for (root, dirs, files) in walkdir(@__DIR__)
    for file in files
        if isnothing(match(r"^test-.*\.jl$", file))
            continue
        end
        title = titlecase(replace(splitext(file[6:end])[1], "-" => " "))
        @testset "$title" begin
            include(file)
        end
    end
end
