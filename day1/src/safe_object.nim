import file_loader

type Safe* = object
  current_value*: int = 50
  password*: int = 0
  updated_passwords*: bool = false
  max_value: int = 99
  min_value: int = 0

func increment_safe(self: var Safe, value_to_increment: int): void =
  var new_value: int = self.current_value + value_to_increment
  if new_value > self.max_value:
    while new_value > self.max_value:
      new_value = self.min_value + (new_value - (self.max_value + 1))
      if (self.updated_passwords):
        self.password += 1
  if (new_value == 0 and not self.updated_passwords):
    self.password += 1
  self.current_value = new_value

func decrement_safe(self: var Safe, value_to_decrement: int): void =
  var new_value: int = self.current_value - value_to_decrement
  if new_value < self.min_value:
    while new_value < self.min_value:
      new_value = (self.max_value + 1) + new_value
      if (self.updated_passwords):
        self.password += 1
  if (new_value == 0 and not self.updated_passwords):
    self.password += 1
  self.current_value = new_value

func process_instructions_on_safe*(self: var Safe, instructions: SafeInstructionFile): int = 
  for instruction in instructions.get_instruction_map():
    if instruction.direction == 'L':
      self.decrement_safe(instruction.value)
    else:
      self.increment_safe(instruction.value)
  return self.password
    