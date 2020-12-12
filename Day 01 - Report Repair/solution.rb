#!/usr/bin/env ruby

# Load input
(puts "USAGE: #{__FILE__} input_file"; exit) unless ARGV.any?
file_path = ARGV[0]
(puts "File not found: #{file_path}"; exit) unless File.file?(file_path)
input = IO.read(file_path)


# Parse input
numbers = input.split(/\n+/).collect{|str| str.to_i }



### Solution1 - Short and ugly
## Write down a working solution as quick as possible.
puts "#### Solution 1 - Short coding time, very ugly code ####"

# Answer 1
answer = 0
numbers.each_index{|i| n=numbers[i]; numbers.each_index{|ii| nn=numbers[ii]; answer = n*nn if n+nn==2020} }
puts "[Answer 1] Multiply 2 entries which sum is 2020: #{ answer }"

# Anser 2
answer = 0
numbers.each_index{|i| n=numbers[i]; numbers.each_index{|ii| nn=numbers[ii]; numbers.each_index{|iii| nnn=numbers[iii]; answer = n*nn*nnn if n+nn+nnn==2020} } }
puts "[Answer 2] Multiply 3 entries which sum is 2020: #{ answer }"
puts



### Solution2 - Recursive
## Has room for optimization: the same combination of numbers are tested multiple times.
puts "#### Solution 2 - Recursive ####"

# Helper function
def recursive(numbers, sum, count, indexes = [])
  numbers.each_index do |i|
    next if indexes.include?(i)
    work_indexes = indexes + [i]

    work_indexes.count >= count ? answer = work_indexes.collect{|index| numbers[index] }
                                : answer = recursive(numbers, sum, count, work_indexes)

    return answer if answer.count == count and answer.sum == sum
  end

  return []
end

# Answer 1
answer = recursive(numbers, 2020, 2).inject(&:*)
puts "[Answer 1] Multiply 2 entries which sum is 2020: #{ answer }"

# Answer 2
answer = recursive(numbers, 2020, 3).inject(&:*)
puts "[Answer 2] Multiply 3 entries which sum is 2020: #{ answer }"
puts



### Solution 3 - Iterative
## Iterative: Will not fail due to too many recursions (if variable `count` is set to a very high number)
## Optimized: each combination of numbers is only tested once
## Feature: can return all possible anwsers, not just the first one
puts "#### Solution 3 - Iterative ####"

# Helper function
def iterative(numbers, sum, count, all_answers: false)
  # `indexes` contains indexes used with variable `numbers`
  # Example of initial indexes:
  #   [1,0]      (when count == 2)
  #   [2,1,0]    (when count == 3)
  #   [3,2,1,0]  (when count == 4)
  indexes = Array.new(count) {|i| count - (i+1) }
  pointer = 0  # Points to an index in variable `indexes`

  max_index = numbers.count - 1
  max_pointer = indexes.count - 1

  # Result variable
  answers = []

  # The loop will increment the `indexes` like this (when max_index == 9):
  #   [2,1,0] -> [3,1,0] -> [4,1,0] -> ... -> [9,1,0] -> [3,2,0] -> [4,2,0] -> ...
  #   [8,7,3] -> [9,7,3] -> [9,8,3] -> [6,5,4] -> ...
  loop do
    ## Insert your code here, START
    answer = indexes.collect{|i| numbers[i] }

    if answer.sum == sum
      answers << answer
      break unless all_answers
    end
    ## Insert your code here, END

    ## loop control code, START
    # Change the pointer if we have reached the maximum allowed index
    # Code is complex since it avoids storing multiple indexes of same value in variable `indexes´
    # Examples (when max_index == 9)
    #   [9,1,0]  # Point pointer on 1, since 9 has reached maximum allowed index
    #   [9,8,0]  # Point pointer on 0, since both 9 and 8 has reached maximum allowed index
    #   [9,8,7]  # Stop, all indexes has reached their maximum allowed index
    loop_end = while indexes[pointer] + pointer >= max_index
                 break true if pointer == max_pointer
                 pointer += 1
               end

    # Stop: All combinations of numbers has been exhausted
    break if loop_end

    # Increment (fetch the next number)
    # this is done each loop
    indexes[pointer] += 1

    # Increment other indexes (if necessary) without reperating previous combinations
    # Examples (max_index == 9): 
    #   [9,2,0] -> [4,3,0]
    #   [9,8,3] -> [6,5,4]
    while pointer > 0 do
      index = indexes[pointer] + 1
      pointer -= 1
      indexes[pointer] = index
    end
    ## loop control code, END
  end

  return answers if all_answers
  return answers.first
end

# Answer 1
answer = iterative(numbers, 2020, 2).inject(&:*)
puts "[Answer 1] Multiply 2 entries which sum is 2020: #{ answer }"

# Answer 2
answer = iterative(numbers, 2020, 3).inject(&:*)
puts "[Answer 2] Multiply 3 entries which sum is 2020: #{ answer }"