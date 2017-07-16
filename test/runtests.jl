using Base.Test, FileIO, QuartzImageIO, ColorTypes
using FixedPointNumbers, TestImages, ImageAxes
using Images  # For ImageMeta
using OffsetArrays

# Saving notes:
# autumn_leaves and toucan fail as of November 2015. The "edges" of the
# leaves are visibly different after a save+load cycle. Not sure if the
# reader or the writer is to blame. Probably an alpha channel issue.
# Mri-stack and multichannel timeseries OME are both image stacks,
# but the save code only saves the first frame at the moment.

mydir = tempdir() * "/QuartzImages"
ispath(mydir) || mkdir(mydir)

@testset "TestImages" begin
    @testset "House" begin
        name = "house"
        img = testimage(name)
        @test ndims(img) == 2
        @test eltype(img) == GrayA{N0f8}
        @test size(img) == (512, 512)
        out_name = joinpath(mydir, name * ".tif")
        save(out_name, img)
        oimg = load(out_name)
        @test size(oimg) == size(img)
        @test eltype(oimg) == eltype(img)
        @test oimg == img
    end
    @testset "Jetplane" begin
        name = "jetplane"
        img = testimage(name)
        @test ndims(img) == 2
        @test eltype(img) == GrayA{N0f8}
        @test size(img) == (512, 512)
        out_name = joinpath(mydir, name * ".tif")
        save(out_name, img)
        oimg = load(out_name)
        @test size(oimg) == size(img)
        @test eltype(oimg) == eltype(img)
        @test oimg == img
    end
end

rm(mydir, recursive=true)

@test !isdefined(:ImageMagick)
