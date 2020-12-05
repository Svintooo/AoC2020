#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
boarding_passes = input.split(/\n+/)


# Helper function
def get_seat_id(boarding_pass)
  rows = 128  # Number of rows
  cols = 8    # Number of columns
  row = 0     # 0-127
  col = 0     # 0-7
  row_add = rows
  col_add = cols

  boarding_pass.chars.each do |c|
    if ['F','B'].include?(c)
      row_add /= 2
      row += row_add if c == 'B'
    elsif ['L','R']
      col_add /= 2
      col += col_add if c == 'R'
    else
      raise "ParseError: #{boarding_pass.inspect}"
    end
  end

  seat_id = (row * 8) + col
  return seat_id
end

# Answer 1
max_seat_id = boarding_passes.collect{|boarding_pass| get_seat_id(boarding_pass) }
                             .max
puts "[Answer 1] Max Seat ID: #{max_seat_id}"


# Answer 2
seat_ids = boarding_passes.collect{|boarding_pass| get_seat_id(boarding_pass) }
                          .sort
my_seat_id = seat_ids.first
seat_ids.each{|seat_id| break if my_seat_id != seat_id; my_seat_id += 1 }
puts "[Answer 2] My Seat ID: #{my_seat_id}"
