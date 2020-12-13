#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Answer 1

# Parse input
input_lines = input.split(/\n+/)

earliest_timestamp = input_lines[0].to_i

bus_ids = input_lines[1].split(",").select{|id| id =~ /^[0-9]+$/ }.collect{|id| id.to_i }

# Find earliest bus, and shortest wait time
bus_id, wait_time = bus_ids.collect{|bus_id| [bus_id, bus_id - (earliest_timestamp % bus_id)] }.min{|(_,wait_time1), (_,wait_time2)| wait_time1 <=> wait_time2 }

# Print
answer = bus_id * wait_time
puts "[Answer 1] ID of earliest bus multiplied by wait time: #{ answer }"



## Answer 2

# Print
answer = nil
puts "[Answer 2] asdf: #{ answer }"
