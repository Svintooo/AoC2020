#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
# Example input:
#   "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."
#   "faded blue bags contain no other bags."
# Example output:
#   {
#     "shiny gold" => {"dark olive" => 1 "vibrant plum" => 2},
#     "faded blue"  => {}
#   }
rules = input.gsub(/ bags?/, '')  # Remove all instances of " bag" and " bags"
             .gsub(/\.$/, '')     # Remove ending dots
             .split(/\n/)         # Split the input into an array of input lines
             .collect{|rule| rule.split(/ contain /) }  # Split each line into an array
             .to_h                # Convert the input into a hashmap

rules.each do |bag, inner_bags|
  rules[bag] = {}
  next if inner_bags == "no other"

  inner_bags.split(/, /).each do |str|
    amount, inner_bag = str.split(/\s+/, 2)  # Ex: "2 vibrant plum" => ["2", "vibrant plum"]
    rules[bag][inner_bag] = amount.to_i      # Note: Converts string to integer
  end
end


# Answer 1
reverse_rules = {}

# Example rules:
#   {
#     "shiny gold" => {"dark olive" => 1, "vibrant plum" => 2},
#     "faded blue"  => {}
#   }
# Example reverse_rules:
#   {
#     "dark olive" => ["shiny gold"],
#     "vibrant plum"  => ["shiny gold"]
#   }
rules.each do |bag, inner_bags|
  inner_bags.keys.each do |inner_bag|
    reverse_rules[inner_bag] ||= []  #Note: Only assings if not exists
    reverse_rules[inner_bag] << bag  # Add bag to array
  end
end

outermost_bags = []
bags = ["shiny gold"]

while bags.any?
  bag = bags.shift  #Note: Removes from array at the beginning
  next unless reverse_rules.has_key?(bag)

  reverse_rules[bag].each do |inner_bag|
    next if outermost_bags.include?(inner_bag)  # Do not count the same type of bag twice
    outermost_bags << inner_bag
    bags << inner_bag  #Note: Adds to array at the end
  end
end

answer = outermost_bags.count
puts "[Answer 1] the number of bag colors that can eventually contain at least one shiny gold bag: #{ answer }"


# Answer 2
bag_count = 0
bags = ["shiny gold"]

while bags.any?
  bag = bags.shift  #Note: Removes from array at the beginning
  next unless rules.has_key?(bag)

  rules[bag].each do |inner_bag, amount|
    bags += Array.new(amount, inner_bag)  #Note: Array.new(3, "inner_bag") => ["inner_bag", "inner_bag", "inner_bag"]
                                          #Note: Adds to array at the end
    bag_count += amount
  end
end

answer = bag_count
puts "[Answer 2] The amount of individual bags are required inside a shiny gold bag: #{ answer }"