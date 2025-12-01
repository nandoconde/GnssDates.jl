using PrecompileTools: @setup_workload, @compile_workload

@setup_workload begin
    @compile_workload begin
        # ancillary variables
        wn = 1191
        tow = 441600
        gt = GnssTime(wn, tow)
        gct = GnssTimeCoarse(wn, tow)
        d = DateTime(gt)


        # constructors
        GnssTime(wn, tow)
        GnssTime(wn, tow + 0.5)
        GnssTime(wn, tow, 0.0)
        GnssTimeCoarse(wn, tow)
        GPST(wn, tow)
        GPST(wn, tow + 0.5)
        GPST(wn, tow, 0.5)
        GST(wn, tow)
        GST(wn, tow + 0.5)
        GST(wn, tow, 0.5)
        BDT(wn, tow)
        BDT(wn, tow + 0.5)
        BDT(wn, tow, 0.5)
        GLONASST(d)

        # wn & tow parts
        wntow(GnssTime, d)
        wntow(GnssTime, gt)
        wntow(GnssTime, gct)
        wntow(GnssTimeCoarse, d)
        wntow(GnssTimeCoarse, gt)
        wntow(GnssTimeCoarse, gct)
        wntow(GPST, d)
        wntow(GPST, gt)
        wntow(GPST, gct)
        wntow(BDT, d)
        wntow(BDT, gt)
        wntow(BDT, gct)
        wntow(GST, d)
        wntow(GST, gt)
        wntow(GST, gct)

        # delta time
        # TODO

    end
end
