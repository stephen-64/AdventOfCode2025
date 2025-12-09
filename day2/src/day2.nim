import id_tracker

when isMainModule:
  var id_ranges: seq[id_range] = generate_id_ranges("tests/input.txt")
  echo(find_and_add_all_invalid_ids(id_ranges, 2))
  
