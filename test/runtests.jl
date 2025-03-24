using XYZ
using Test

@testset "XYZ.jl" begin
  @test typeof(read_xyz_file("input.txt")) == Atoms
end
