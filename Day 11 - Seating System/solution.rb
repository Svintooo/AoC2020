#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Answer 1

# Parse input
seats = input.split(/\n+/).collect{|str| str.chars }

# Help method for finding all adjacent seats
def seats.adjacent(i, j)
  adjacent_seats = []

  [
    [-1, -1], [-1,  0], [-1, +1],
    [ 0, -1],           [ 0, +1],
    [+1, -1], [+1,  0], [+1, +1],
  ].each do |i_delta, j_delta|
    adj_i = i + i_delta
    adj_j = j + j_delta
    next if adj_i < 0 || adj_i >= self.count
    next if adj_j < 0 || adj_j >= self[adj_i].count
    adjacent_seats << self[adj_i][adj_j]
  end

  return adjacent_seats
end

# Modify seats until no modifications are longer made
loop do
  #pp seats #DEBUG
  seating_changes = []

  # Find all seats that should be modified
  (0).upto(seats.count-1).each do |i|
    (0).upto(seats[i].count-1).each do |j|
      case seats[i][j]
        when "L" then seating_changes << [i,j] if seats.adjacent(i,j).count("#") == 0
        when "#" then seating_changes << [i,j] if seats.adjacent(i,j).count("#") >= 4
      end
    end
  end

  # Modify seats
  seating_changes.each do |i,j|
    case seats[i][j]
      when "L" then seats[i][j] = "#"
      when "#" then seats[i][j] = "L"
    end
  end

  break if seating_changes.empty?
end

# Print
answer = seats.inject(0){|count, seat_row| count += seat_row.count("#") }
puts "[Answer 1] Numbers of seats the ends up occupied: #{ answer }"



## Answer 2

# Print
answer = nil
puts "[Answer 2] asdf: #{ answer }"
