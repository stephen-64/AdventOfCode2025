import std/tables

type SafeInstructionFile = object
    instruction_map: seq[Table[string, int]] = newSeq[Table[string, int]]()

