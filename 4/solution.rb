#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
passports = input.split(/\n\n+/).collect{|passport| passport.split(/\s+/).collect{|key_value| key_value.split(":") }.to_h }


# Answer 1
required_fields = [
  "byr",  # Birth Year
  "iyr",  # Issue Year
  "eyr",  # Expiration Year
  "hgt",  # Height
  "hcl",  # Hair Color
  "ecl",  # Eye Color
  "pid",  # Passport ID
  #"cid",  # Country ID
]
valid_passports_count = passports.select{|passport| required_fields.all?{|fld| passport.has_key?(fld) } }.count
puts "[Answer 1] Number of valid passports: #{valid_passports_count}"


# Answer 2
required_fields = [
  "byr",  # Birth Year
  "iyr",  # Issue Year
  "eyr",  # Expiration Year
  "hgt",  # Height
  "hcl",  # Hair Color
  "ecl",  # Eye Color
  "pid",  # Passport ID
  #"cid",  # Country ID
]
validations = {
  "byr" => ->(o){ n = o.to_i; o.length == 4 && 1920 <= n && n <= 2002 },
  "iyr" => ->(o){ n = o.to_i; o.length == 4 && 2010 <= n && n <= 2020 },
  "eyr" => ->(o){ n = o.to_i; o.length == 4 && 2020 <= n && n <= 2030 },
  "hgt" => ->(o){ (o =~ /^[0-9]+(cm|in)$/) && (n = o.gsub(/(cm|in)$/,'').to_i; (o =~ /cm/ && 150 <= n && n <= 193) || (o =~ /in/ && 59 <= n && n <= 76)) },
  "hcl" => ->(o){ o =~ /^#[0-9a-f]{6}/ },
  "ecl" => ->(o){ ["amb","blu","brn","gry","grn","hzl","oth"].include?(o) },
  "pid" => ->(o){ o =~ /^[0-9]{9}$/ },
  "cid" => ->(o){ true },
}
valid_passports_count = passports.select{|passport| required_fields.all?{|fld| passport.has_key?(fld) } && passport.all?{|key,value| validations[key].call(value) } }.count
puts "[Answer 2] Number of valid passports: #{valid_passports_count}"