import std/strutils

type SafeInstruction = object
    direction*: char
    value*: int

type SafeInstructionFile* = object
    file_contents: string
    instruction_map: seq[SafeInstruction] = newSeq[SafeInstruction]()

func process_file_contents(file: var SafeInstructionFile): void =
    for line in file.file_contents.splitLines():
        var sf: SafeInstruction = SafeInstruction()
        sf.direction = line[0]
        sf.value = parseInt(line[1..line.len()-1])
        file.instruction_map.add(sf)

proc load_file_into_mem*(file_name: string): SafeInstructionFile =
    var safe_file: SafeInstructionFile = SafeInstructionFile()
    safe_file.file_contents = readFile(file_name)
    safe_file.process_file_contents()
    return safe_file

func get_instruction_map*(self: SafeInstructionFile): seq[SafeInstruction] = 
    return self.instruction_map