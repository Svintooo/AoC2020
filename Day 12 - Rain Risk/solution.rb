#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Validate input
input.each_line(chomp: true) do |line|
  valid = true
  valid &= line =~ /^[NSEWLRF][0-9]+$/
  # Left and right turns must be evenly divisible by 90 degrees
  valid &= line[1..-1].to_i % 90 == 0 if line =~ /^[LR]/
  unless valid
    puts "Invalid input line: #{line.inspect}"
    exit
  end
end



## Parse input
navigation_instructions = input.split(/\n+/).collect{|line| [ line[0].to_sym, line[1..-1].to_i ] }



## Answer 1

# Define Boat
Boat = Struct.new(:direction, :position) do
  self::DIRECTIONS = [:N, :E, :S, :W]

  def turn_left(degrees)
    turns = degrees / 90
    index = self.class::DIRECTIONS.index(self.direction)
    new_index = (index - turns) % self.class::DIRECTIONS.count
    self.direction = self.class::DIRECTIONS[new_index]
  end

  def turn_right(degrees)
    turns = degrees / 90
    index = self.class::DIRECTIONS.index(self.direction)
    new_index = (index + turns) % self.class::DIRECTIONS.count
    self.direction = self.class::DIRECTIONS[new_index]
  end

  def move_forward(distance)
    case self.direction
      when :N then self.position.y += distance
      when :S then self.position.y -= distance
      when :E then self.position.x += distance
      when :W then self.position.x -= distance
      else raise "Invalid direction: #{self.direction}"
    end
  end
end

# Define Position
Boat::Position = Struct.new(:x, :y)

# create a boat
boat = Boat.new(:E, Boat::Position.new(0, 0))

# Move the boat according to the navigation instructions
navigation_instructions.each do |action, value|
  case action
    when :N then boat.position.y += value
    when :S then boat.position.y -= value
    when :E then boat.position.x += value
    when :W then boat.position.x -= value
    when :L then boat.turn_left(value)
    when :R then boat.turn_right(value)
    when :F then boat.move_forward(value)
  end
end


# Print
answer = boat.position.x + boat.position.y
puts "[Answer 1] Manhattan distance: #{ answer }"



## Answer 2

# Print
answer = nil
puts "[Answer 2] asdf: #{ answer }"
