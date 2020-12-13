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
navigation_instructions = input.split(/\n+/).collect{|line| [ line[0].to_sym, line[1..-1].to_i ] }



## Answer 1

# Define Boat
Boat = Struct.new(:position, :direction) do
  @@directions = [:N, :E, :S, :W]

  def turn_left(turns)
    index = @@directions.index(self.direction)
    new_index = (index - turns) % @@directions.count
    self.direction = @@directions[new_index]
  end

  def turn_right(turns)
    index = @@directions.index(self.direction)
    new_index = (index + turns) % @@directions.count
    self.direction = @@directions[new_index]
  end

  def move_forward(distance)
    case self.direction
      when :N then self.position.y += 1
      when :S then self.position.y -= 1
      when :E then self.position.x += 1
      when :W then self.position.x -= 1
      else raise "Invalid direction: #{self.direction}"
    end
  end
end

# Define Position
Boat::Position = Struct.new(:x, :y)

# create a boat
boat = Boat.new(position: Boat::Position.new(x: 0, y: 0), direction: 'E')

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
