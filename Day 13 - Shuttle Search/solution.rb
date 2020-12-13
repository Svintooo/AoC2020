#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Parse input
input_lines = input.split(/\n+/)

earliest_timestamp = input_lines[0].to_i

bus_ids = input_lines[1].split(",").select{|id| id =~ /^[0-9]+$/ }.collect{|id| id.to_i }


## Answer 1

# Print
answer = nil
puts "[Answer 1] asdf: #{ answer }"



## Answer 2

# Print
answer = nil
puts "[Answer 2] asdf: #{ answer }"
