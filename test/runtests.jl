using Colorsys
using Test

@testset "Colorsys.jl" begin
    @testset "_v" begin
        @test Colorsys._v(1,2,0.1) ≈ 1.6
        @test Colorsys._v(1,2,0.4) == 2
        @test Colorsys._v(1,2,0.6) ≈ 1.4
        @test Colorsys._v(1,2,0.8) == 1
    end
    y,i,q = rgb2yiq(120, 130, 140)
    @test y≈0.5023529411 && i≈-0.0360784313 && q≈0.0039215686
    r,g,b = yiq2rgb(0.8, 0.6, 0.4)
    @test (r,g,b) == (255,96,211)
    h,l,s = rgb2hls(120, 130, 140)
    @test h≈210.0000000000 && l≈0.5098039215 && s≈0.0800000000
    r,g,b = hls2rgb(120, 0.6, 0.4)
    @test (r,g,b) == (112,193,112)
    @testset "rgb2hsv" begin
        h,s,v = rgb2hsv(120, 130, 140)
        @test h≈210.0000000000 && s≈0.1428571428 && v≈0.5490196078
        h,s,v = rgb2hsv(120, 120, 120)
        @test h≈0.0 && s≈0.0 && v≈0.4705882352
        h,s,v = rgb2hsv(220, 130, 240)
        @test h≈289.0909090909 && s≈0.4583333333 && v≈0.9411764705
    end
    @testset "hsv2rgb" begin
        r,g,b = hsv2rgb(40, 0.6, 0.4)
        @test (r,g,b) == (102,81,40)
        r,g,b = hsv2rgb(80, 0.6, 0.4)
        @test (r,g,b) == (81,102,40)
        r,g,b = hsv2rgb(120, 0.6, 0.4)
        @test (r,g,b) == (40,102,40)
        r,g,b = hsv2rgb(200, 0.6, 0.4)
        @test (r,g,b) == (40,81,102)
        r,g,b = hsv2rgb(260, 0.6, 0.4)
        @test (r,g,b) == (61,40,102)
        r,g,b = hsv2rgb(320, 0.6, 0.4)
        @test (r,g,b) == (102,40,81)
        r,g,b = hsv2rgb(120, 0, 0.2)
        @test (r,g,b) == (51,51,51)
    end
    h,l,s = yiq2hls(0.8, 0.6, 0.4)
    @test h≈316.6037735849 && l≈0.6882352941 && s≈1.0000000000
    h,s,v = yiq2hsv(0.8, 0.6, 0.4)
    @test h≈316.6037735849 && s≈0.6235294117 && v≈1.0000000000
    y,i,q = hls2yiq(120, 0.6, 0.4)
    @test y≈0.6266274509 && i≈-0.0889411764 && q≈-0.1651764705
    h,s,v = hls2hsv(120, 0.6, 0.4)
    @test h≈120.0000000000 && s≈0.4196891191 && v≈0.7568627450
    y,i,q = hsv2yiq(120, 0.6, 0.4)
    @test y≈0.3003137254 && i≈-0.0680784313 && q≈-0.1264313725
    h,l,s = hsv2hls(120, 0.6, 0.4)
    @test h≈120.0000000000 && l≈0.2784313725 && s≈0.4366197183
end
