import safe_object
import file_loader

when isMainModule:
  var safe: Safe = Safe()
  safe.updated_passwords = true
  var safe_instruction_file: SafeInstructionFile = load_file_into_mem("tests/test_1.txt")
  echo(safe.process_instructions_on_safe(safe_instruction_file))
  