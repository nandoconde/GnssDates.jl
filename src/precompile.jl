using PrecompileTools: @setup_workload, @compile_workload

@setup_workload begin
    @compile_workload begin
        GPST(10, 9) - GST(11, -4)
        GnssTime(10, 9, -0.5) - CoarseTimeDelta(10, 9)
        GST(1, 1) + FineTimeDelta(1, 0, -0.25)
        2 * FineTimeDelta(1, 0, 0.4) + 3 * CoarseTimeDelta(10, 9) - FineTimeDelta(0, 0, 0.25)
        GPST(GST(GnssTime(10, 0, -0.25)))
    end
end
