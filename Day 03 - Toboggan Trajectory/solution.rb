#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
terrain = input.split(/\n+/)


# Answer 1
trees = 0
pos = 0
terrain.each{|str| trees += 1 if str[pos] == '#'; pos = (pos + 3) % str.length }.count
puts "[Answer 1] Encountered trees: #{trees}"


# Answer 2
def count_trees(terrain, right_steps, down_steps)
  trees = 0
  horizontal_position = 0
  vertical_position = 0

  while (vertical_position < terrain.length)
    row = terrain[vertical_position]
    trees += 1 if row[horizontal_position] == '#'
    horizontal_position = (horizontal_position + right_steps) % row.length
    vertical_position += down_steps;
  end

  return trees
end

if false #DEBUG
  puts "[Answer 2][DEBUG] Encountered trees on slope 1,1: #{ count_trees(terrain, 1, 1) }"
  puts "[Answer 2][DEBUG] Encountered trees on slope 3,1: #{ count_trees(terrain, 3, 1) }"
  puts "[Answer 2][DEBUG] Encountered trees on slope 5,1: #{ count_trees(terrain, 5, 1) }"
  puts "[Answer 2][DEBUG] Encountered trees on slope 7,1: #{ count_trees(terrain, 7, 1) }"
  puts "[Answer 2][DEBUG] Encountered trees on slope 1,2: #{ count_trees(terrain, 1, 2) }"
end

multiple = [ [1,1], [3,1], [5,1], [7,1], [1,2] ].collect{|args| count_trees(terrain, *args) }.inject(&:*)
puts "[Answer 2] Multiply encountered trees on all slopes: #{multiple}"