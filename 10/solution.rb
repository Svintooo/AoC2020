#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Parse input
adapter_joltages = input.split(/\n+/)
                        .collect{|n| n.to_i }

charging_outlet_joltage = 0
device_joltage = adapter_joltages.max + 3

unit_joltages = [charging_outlet_joltage] + adapter_joltages.sort + [device_joltage]



## Answer 1
joltage_difference_counts = {}
joltage_difference_counts.default = 0

# Count all joltage differences
# # Since the list of units is sorted by joltage, we know that they can be plugged into each other in order.
# # So we only need to compare the joltage of a unit with the joltage of the next unit.
joltage = 0
unit_joltages.each do |unit_joltage|
  joltage_difference_counts[(unit_joltage - joltage).abs] += 1
  joltage = unit_joltage
end

# Print
answer = joltage_difference_counts[1] * joltage_difference_counts[3]
puts "[Answer 1] 1-jolt differences multiplied by 3-jolt differences: #{ answer }"



## Answer 2

# For each unit: list all units that can be plugged into it
# Example (unit_joltages):
#   [
#      0,  # Unit 0
#      1,  # Unit 1
#      4,  # Unit 2
#      5,  # Unit 3
#      6,  # Unit 4
#      7,  # Unit 5
#     10,  # Unit 6
#   ]
# Example (compatible_units):  # note that the values below are indexes in unit_joltages
#   [
#     [1],        # Unit 0
#     [2],        # Unit 1
#     [3, 4, 5],  # Unit 2
#     [4, 5],     # Unit 3
#     [5],        # Unit 4
#     [6],        # Unit 5
#     [],         # Unit 6
#   ]
compatible_units = []

unit_joltages.each_with_index do |unit1_joltage, unit1_index|
  compatible_units[unit1_index] = []
  unit_joltages.each_with_index do |unit2_joltage, unit2_index|
    compatible_units[unit1_index] << unit2_index if (unit1_index != unit2_index) && (unit1_joltage <= unit2_joltage) && (unit1_joltage >= unit2_joltage-3)
  end
end

# For each unit: count all possible combinations of plugged units that can be used to plug into the device
# Example (compatible_units):  # note that the values below are indexes in unit_joltages
#   [
#     [1],        # Unit 0
#     [2],        # Unit 1
#     [3, 4, 5],  # Unit 2
#     [4, 5],     # Unit 3
#     [5],        # Unit 4
#     [6],        # Unit 5
#     [],         # Unit 6
#   ]
# Example (unit_combination_counts):
#   [
#     4,  # Unit 0
#     4,  # Unit 1
#     4,  # Unit 2 has 4 combinations (it can be plugged into either unit 3, 4, or 5)
#     2,  # Unit 3 has 2 combinations (it can be plugged into either unit 4 or 5, each which has only one combination)
#     1,  # Unit 4 has 1 combination (it can only be plugged into unit 5)
#     1,  # Unit 5 has 1 combination (it can only be plugged into unit 6)
#     1,  # Unit 6 has 1 combination (it is plugged directly into the device)
#   ]
unit_combination_counts = Array.new(compatible_units.count, 0)  # Array with length compatible_units.count, each index initiated with the value 0
unit_combination_counts[-1] = 1  # Set value 1 on the last index (the device)

(compatible_units.count-2).downto(0).each do |unit_index|  # Traverse through the units backwards
  unit_combination_counts[unit_index] = compatible_units[unit_index].collect{|unit2_index| unit_combination_counts[unit2_index] }.sum
end
total_combinations_count = unit_combination_counts[0]

# Print
answer = total_combinations_count
puts "[Answer 2] Number of ways to arrange the adapters: #{ answer }"
