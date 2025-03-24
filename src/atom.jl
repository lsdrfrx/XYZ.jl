struct AtomNode
	name::String
	X::Float16
	Y::Float16
	Z::Float16
end

mutable struct Atoms
  description::String
  atom_count::Int16
  atoms::Array{AtomNode}
end

function parse_atom(node_line::String)::AtomNode
	name, x, y, z = filter(x -> !isempty(x), split(node_line, ' '))
	AtomNode(name, parse(Float16, x), parse(Float16, y), parse(Float16, z))
end

function to_xyz(atoms::Atoms)::String
  data = "$(atoms.atom_count)\n" * "$(atoms.description)\n"

  for row in atoms.atoms
    data *= "$(row.name)\t$(row.X)\t$(row.Y)\t$(row.Z)"
  end

  data
end

function to_json(atoms::Atoms)::String
  data = "{'atom_count': $(atoms.atom_count), 'description': '$(atoms.description)', 'atoms': ["
  for row in atoms.atoms
    data *= "{'name': '$(row.name)', 'x': $(row.X), 'y': $(row.Y), 'z': $(row.Z)},"
  end

  data = data[:end-1] * "]}" # trim trailing comma

  data
end
