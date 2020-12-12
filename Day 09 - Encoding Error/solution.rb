#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Parse input
encrypted_data = input.split(/\n+/).collect{|number| number.to_i }



## Answer 1
prev_numbers_length = 25

invalid_number = nil

# Extract the preamble
prev_numbers = []
encrypted_data[0...prev_numbers_length].each do |number|
  prev_numbers << number
end

# Find the first invalid number
encrypted_data[prev_numbers_length..-1].each do |number|
  unless prev_numbers.any?{|prev_num1| prev_numbers.any?{|prev_num2| (prev_num1 != prev_num2) && (prev_num1 + prev_num2 == number) } }
    invalid_number = number
    break
  end

  prev_numbers.shift
  prev_numbers << number
end

# Print
answer = invalid_number
puts "[Answer 1] the fist invalid number: #{ answer }"



# Answer 2
numbers = nil

# Find contiguous numbers which sum equals to invalid_number
encrypted_data.each_index do |index|
  numbers = []

  encrypted_data[index..-1].each do |number|
    numbers << number
    break if numbers.sum >= invalid_number
  end

  break if numbers.sum == invalid_number
end

# Calculate the encryption weakness
encryption_weakness = numbers.min + numbers.max

# Print
answer = encryption_weakness
puts "[Answer 2] The encryption weakness: #{ answer }"