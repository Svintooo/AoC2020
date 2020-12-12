#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
passwords = input.split(/\n/).collect{|str| pw = str.split(/-|:? /, 4); pw[0] = pw[0].to_i; pw[1] = pw[1].to_i; pw }


# Answer 1
valid_passwords_count = passwords.select{|i1,i2,char,pw| count = pw.gsub(/[^#{char}]/,'').length; (i1 <= count && count <= i2) }.count
puts "[Answer 1] Number of valid passwords: #{valid_passwords_count}"


# Answer 2
valid_passwords_count = passwords.select{|i1,i2,char,pw| count = [i1,i2].select{|i| pw[i-1] == char }.count; count == 1 }.count
puts "[Answer 2] Number of valid passwords: #{valid_passwords_count}"