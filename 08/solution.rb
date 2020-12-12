#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



# Parse input
# # Example input:
#   "nop +0"
#   "acc +1"
#   "jmp -4"
# # Example boot_code:
#  [
#    ["nop",  0],
#    ["acc",  1],
#    ["jmp", -4]
#  ]
boot_code = input.split(/\n+/)
                 .collect{|instruction| instruction.split(/\s+/, 2) }
                 .collect{|op,inc| [op, inc.to_i] }



# Answer 1
accumulator = 0
instruction_pointers = []
pointer = 0

# loop: Run the code.
#       Stop running when a pointer is repeated.
while not instruction_pointers.include?(pointer)
  instruction_pointers << pointer
  operation, increment = boot_code[pointer]
  pointer += 1

  # Code execution
  case operation
    when "acc" then accumulator += increment
    when "jmp" then pointer += increment - 1
    when "nop"
    else raise "Error"
  end
end

answer = accumulator
puts "[Answer 1] value of the accumulator immediately before any instruction is executed a second time: #{ answer }"



# Answer 2
# Brute force solution: Change every nop and jmp (one at a time), run the code, see if it works.
accumulator = 0
modification_pointer = 0
pointer = 0

# Outer loop: Decide which instruction to modify.
boot_code.each_index do |index|
  modification_pointer = index
  next unless ["nop", "jmp"].include? boot_code[modification_pointer][0]

  accumulator = 0
  instruction_pointers = []
  pointer = 0

  # Inner loop: Run the code. Modify the selected instruction when encountered.
  #             Stop running either when pointer goes beyond the boot_code, OR when a pointer is repeated.
  while pointer < boot_code.count and not instruction_pointers.include?(pointer)
    instruction_pointers << pointer
    operation, increment = boot_code[pointer]

    # Modify the selected instruction
    if pointer == modification_pointer
      operation = case operation
        when "nop" then "jmp"
        when "jmp" then "nop"
        else raise "Error1"
      end
    end

    pointer += 1

    # Code execution
    case operation
      when "acc" then accumulator += increment
      when "jmp" then
        break if increment == 0  # Prevent infinite loop
        pointer += increment - 1
      when "nop"
      else raise "Error2"
    end
  end

  break if pointer == boot_code.count  # Pointer has reached the instruction right after the boot_code
end

answer = accumulator
instruction = boot_code[modification_pointer]
instruction_modified  = instruction.clone
instruction_modified[0] == "nop" ? instruction_modified[0] = "jmp" : instruction_modified[0] = "nop"

if pointer == boot_code.count  # The pointer is exactly at the instruction after the last one in the boot_code
  puts "[Answer 2] the accumulator value after the program terminates: #{ answer }"
  puts "           operation on row #{ modification_pointer+1 } was changed from '#{ instruction.join(" ") }' to '#{ instruction_modified.join(" ") }'"
else
  puts "[Answer 2] FAILURE: Failed to fix the boot code."
end