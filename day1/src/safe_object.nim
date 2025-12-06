type Safe* = object
  current_value*: int = 50
  max_value: int = 99
  min_value: int = 0

func increment_safe(safe: var Safe, value_to_increment: int): void =
  let new_value: int = safe.current_value + value_to_increment
  if new_value > safe.max_value:
    safe.current_value = safe.min_value + (new_value - safe.max_value)
  else:
    safe.current_value = new_value

func decrement_safe(safe: var Safe, value_to_decrement: int): void =
  let new_value: int = safe.current_value - value_to_decrement
  if new_value < safe.min_value:
    safe.current_value = safe.max_value + new_value
  else:
    safe.current_value = new_value
    