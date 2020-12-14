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
bus_ids = line2.split(",").collect{|bus_id| bus_id =~ /^[0-9]+$/ ? bus_id.to_i : nil }

#
indexes = bus_ids.each_with_index.to_a.select{|bus_id,_| !bus_id.nil? }.collect{|_,index| index }

#increment = 1
#increment = bus_ids[0]
increment = bus_ids.compact.max

increment_bus_id_index = bus_ids.index(increment)
#indexes.delete( increment_bus_id_index )  # Performance boost

#timestamp = 0
timestamp = 100000000000000 - (100000000000000 % increment) + increment

loop do
  timestamp += increment
  real_timestamp = timestamp - increment_bus_id_index
  success = true

  wait_times = []
  indexes.each do |i|
    wait_times[i] = (bus_ids[i] - (timestamp - increment_bus_id_index)) % bus_ids[i]
    success &= wait_times[i] == i
  end

  #puts timestamp
  #(p [real_timestamp, wait_times]; exit) if real_timestamp >= 1068781 # 1202161486 #DEBUG
  #sleep 1
  if success
    #p [real_timestamp, wait_times]
    timestamp = real_timestamp
    break
  end
end

# Print
answer = timestamp
puts "[Answer 2] Earliest timestamp: #{ answer }"
