#A program which, given a dictionary, generates two output files, 'sequences' and 'words'. 'sequences' contains every sequence of four letters that appears in exactly one word of the dictionary, one sequence per line. 'words' contains the corresponding words that contain the sequences, in the same order, again one per line.

input = []
open('dictionary.txt', "r") do |f|
  f.each_line do |line|
    input << line
  end
end
puts input

output = {'carr' => 'carrots'} #TODO replace with real string parsing

open('sequences.txt', 'w') { |f|
  f.puts output.keys
  puts 'Sequences: ' + output.keys.to_s
}

open('words.txt', 'w') { |f|
  f.puts output.values
  puts 'Words: ' + output.values.to_s
}


