#!/usr/bin/env ruby

## Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)



## Parse input
#seats = input.split(/\n+/).collect{|str| str.chars.collect(&:to_sym) }
seats = input.split(/\n+/).collect{|str| str.chars }
#seats = input.split(/\n+/)

def seats.adjacent(i, j)
  adjacent_seats_status = []

  [
    [-1, -1], [-1,  0], [-1, +1],
    [ 0, -1],           [ 0, +1],
    [+1, -1], [+1,  0], [+1, +1],
  ].each do |i_delta, j_delta|
    adj_i = i + i_delta
    adj_j = j + j_delta
    next if adj_i < 0 || adj_i >= self.count
    next if adj_j < 0 || adj_j >= self[i].count
    adjacent_seats_status << self[adj_i][adj_j]
  end

  return adjacent_seats_status
end



## Answer 1
loop do
  #pp seats ;nil #DEBUG
  seating_changes = []
  
  (0).upto(seats.count-1).each do |i|
    (0).upto(seats[i].count-1).each do |j|
      case seats[i][j]
        when "L" then seating_changes << [i,j] if seats.adjacent(i,j).count("#") == 0
        when "#" then seating_changes << [i,j] if seats.adjacent(i,j).count("#") >= 4
      end
    end
  end

  seating_changes.each do |i,j|
    case seats[i][j]
      when "L" then seats[i][j] = "#"
      when "#" then seats[i][j] = "L"
    end
  end
  
  break if seating_changes.empty?
end


## Answer 2
