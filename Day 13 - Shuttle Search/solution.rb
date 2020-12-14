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
bus_ids = input_lines[1].split(",").select{|bus_id| bus_id =~ /^[0-9]+$/ }.collect{|bus_id| bus_id.to_i }

# Find earliest bus, and shortest wait time
bus_id, wait_time = bus_ids.collect{|bus_id| [bus_id, bus_id - (earliest_timestamp % bus_id)] }.min{|(_,wait_time1), (_,wait_time2)| wait_time1 <=> wait_time2 }

# Print
answer = bus_id * wait_time
puts "[Answer 1] ID of earliest bus multiplied by wait time: #{ answer }"



## Answer 2

# Parse input
line1, line2 = input.split(/\n+/)
bus_ids = line2.split(",").collect{|bus_id| bus_id =~ /^[0-9]+$/ ? bus_id.to_i : 0 }

#
work_array = Array.new(bus_ids.count, 0)
indexes = bus_ids.each_with_index.to_a.select{|bus_id,_| bus_id != 0 }.collect{|_,index| index }
increment = bus_ids.first
timestamp = 0 #100000000000000/increment
indexes.shift

loop do
  timestamp += increment
  success = true

  indexes.each do |i|
    work_array[i] = (work_array[i] + increment) % bus_ids[i]
    wait_time = (bus_ids[i] - work_array[i])  # Minutes you have to wait for Bus ID `bus_ids[i]` if time is `timestamp`
    success &= wait_time == i
  end

  break if success
end

# Print
answer = timestamp
puts "[Answer 2] Earliest timestamp: #{ answer }"
