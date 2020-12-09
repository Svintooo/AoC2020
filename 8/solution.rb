#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
boot_code = input.split(/\n+/).collect{|instruction| instruction.split(/\s+/, 2) }.collect{|op,inc| [op, inc.to_i] }


# Answer 1
accumulator = 0
instruction_pointers = []
pointer = 0

while not instruction_pointers.include?(pointer)
  instruction_pointers << pointer
  operation, increment = boot_code[pointer]
  pointer += 1

  case operation
    when "acc" then accumulator += increment
    when "jmp" then pointer += increment - 1
    when "nop"
    else raise "Error"
  end
end

answer = accumulator
puts "[Answer 1] value of in the accumulator immediately before any instruction is executed a second time: #{ answer }"


# Answer 2
accumulator = 0
modification_pointer = 0
pointer = 0

boot_code.each_index do |index|
  modification_pointer = index
  #puts modification_pointer #DEBUG
  next unless ["nop", "jmp"].include? boot_code[modification_pointer][0]

  accumulator = 0
  instruction_pointers = []
  pointer = 0

  while pointer < boot_code.count and not instruction_pointers.include?(pointer)
    instruction_pointers << pointer
    operation, increment = boot_code[pointer]

    if pointer == modification_pointer
      operation = case operation
        when "nop" then "jmp"
        when "jmp" then "nop"
        else raise "Error1"
      end
    end

    pointer += 1

    case operation
      when "acc" then accumulator += increment
      when "jmp" then
        break if increment == 0
        pointer += increment - 1
      when "nop"
      else raise "Error2"
    end
  end

  break if pointer == boot_code.count
end

modification_pointer
pointer
accumulator

answer = accumulator
ins_before = boot_code[modification_pointer]
ins_after  = ins_before.clone
ins_after[0] == "nop" ? ins_after[0] = "jmp" : ins_after[0] = "nop"

if pointer == boot_code.count
  puts "[Answer 2] the accumulator value after the program terminates: #{ answer }"
  puts "           operation on row #{ modification_pointer+1 } was changed from '#{ ins_before.join(" ") }' to '#{ ins_after.join(" ") }'"
else
  puts "[Answer 2] FAILURE: Failed to fix the boot code."
end