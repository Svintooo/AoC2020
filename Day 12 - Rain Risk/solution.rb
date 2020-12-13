#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Validate input
input.each_line(chomp: true) do |line|
  (puts "Invalid input line: #{line.inspect}"; exit) unless line =~ /^[NSEWLRF][0-9]+$/
end



## Parse input
data = input.split(/\n+/)



## Answer 1

# Print
answer = nil
puts "[Answer 1] asdf: #{ answer }"



## Answer 2

# Print
answer = nil
puts "[Answer 2] asdf: #{ answer }"
