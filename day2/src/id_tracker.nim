import std/strutils
import std/re

type id_range* = object
    range_start: int
    range_end: int

proc generate_id_ranges*(file_name: string): seq[id_range] =
    var range_sequence: seq[id_range] = newSeq[id_range]()
    let file_contents: string = readFile(file_name)
    for line in file_contents.split(","):
        let id_range_values: seq[string] = line.split("-")
        var current_range: id_range = id_range(
            range_start: parseInt(id_range_values[0]),
            range_end: parseInt(id_range_values[1]))
        range_sequence.add(current_range)
    return range_sequence

proc return_invalid_ids_in_range(range_to_check: id_range, part: int) : seq[int] = 
    var seq_to_return: seq[int] = newSeq[int]()
    let expression: Regex = if part == 1: re"\b(\d+)\1{1}\b" else: re"\b(\d+)\1+\b"
    for index in countup(range_to_check.range_start, range_to_check.range_end):
        if index.intToStr(1).match(expression):
            seq_to_return.add(index)
    return seq_to_return

proc find_and_add_all_invalid_ids*(ranges_to_check: seq[id_range], part: int) : int = 
    var running_total: int = 0
    for id_range_to_check in ranges_to_check:
        for int_to_add in return_invalid_ids_in_range(id_range_to_check, part):
            running_total += int_to_add
    return running_total


    