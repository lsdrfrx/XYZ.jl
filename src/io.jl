function read_from_xyz(path)::Atoms
  f = open(path, "r")

  atoms = []
  atom_count = readline(f)
  description = readline(f)

  while ! eof(f)
    atom = readline(f) |> parse_atom
    push!(atoms, atom);
  end

  close(f)

  Atoms(description, atom_count, atoms)
end

function read_from_json(path)::Atoms

end

function read_from_string(data::String)::Atoms
  lines = split(data, '\n')

  idx = 1
  atoms = []
  atom_count = lines[idx]
  idx += 1

  description = lines[idx]

  while idx <= length(lines)
    atom = parse_atom(lines[idx])
    push!(atoms, atom)

    idx += 1
  end

  Atoms(description, atom_count, atoms)
end

function save(data::String, path::String)
  open(path, "w") do f
    write(f, data)
  end
end
