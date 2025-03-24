struct Atom
	name::String
	X::Float16
	Y::Float16
	Z::Float16
end

function parse_atom(line::String)::Atom
	name, x, y, z = filter(x -> !isempty(x), split(line, ' '))
	Atom(name, parse(Float16, x), parse(Float16, y), parse(Float16, z))
end

function read_xyz_file(path)::Array{Atom}
	atoms = []
	open(path, "r") do f
		line_number = 0

		atom_count = readline(f)
		line_number += 1
		_ = readline(f)

		while ! eof(f)
			atom = readline(f) |> parse_atom
			push!(atoms, atom);
		end
	end
	atoms
end

println(read_xyz_file("input.xyz"))
