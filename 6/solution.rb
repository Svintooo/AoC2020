#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
custom_declaration_forms = input.split(/\n\n+/).collect{|group| group.split(/\n/) }


# Answer 1
answer = custom_declaration_forms.collect{|group| group.collect{|yes_answers| yes_answers.chars }.flatten.uniq.count }.sum
puts "[Answer 1] The sum of the counts of all yes-answers: #{ answer }"


# Answer 2
answer = custom_declaration_forms.collect{|group| group.collect{|yes_answers| yes_answers.chars }.inject(&:&).count }.sum
puts "[Answer 2] The sum of the counts of all yes-answers: #{ answer }"





## Code Explanation

# Answer 1
answer = custom_declaration_forms.collect{|group|  # For each group of answers
  group.collect{|yes_answers|                      # Take each individuals answer strings (ex: "abc")
    yes_answers.chars                              # And convert them to an array of chars (ex: ["a", "b", "c"])
  }.flatten                                        # Flatten the array of arrays (ex: [["a","b"],["a","c"]] => ["a","b","a","c"])
   .uniq                                           # Remove duplicates (ex: ["a","b","a","c"] => ["a","b","c"])
   .count                                          # Count number of chars (this is the count of unique yes answers for each group)
}.sum                                              # The sum of all counts

# Answer 2
answer = custom_declaration_forms.collect{|group|  # For each group of answers
  group.collect{|yes_answers|                      # Take each individuals answer strings (ex: "abc")
    yes_answers.chars                              # And convert them to an array of chars (ex: ["a", "b", "c"])
  }.inject(&:&)                                    # Only keep the union of all char arrays (ex: [["a","b"],["a","c"]] => ["a"])
                                                   #   NOTE: `[array1, array2, array3].inject(&:&)` is the same as `array1 & array2 & array3`
   .count                                          # Count number of chars (this is the count of common yes answers for each group)
}.sum                                              # The sum of all counts
