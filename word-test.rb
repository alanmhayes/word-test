#A program which, given a dictionary, generates two output files, 'sequences' and 'words'. 'sequences' contains every sequence of four letters that appears in exactly one word of the dictionary, one sequence per line. 'words' contains the corresponding words that contain the sequences, in the same order, again one per line.

#read from input file
def read_input(  input_file  )
  input = []
  open( input_file, "r" ) do |f|
    f.each_line do |line|
      input << line
    end
  end
  puts input
  return input
end

#write output to file
def write_output(  title, entries  )
  open(title+'.txt', 'w') { |f|
    f.puts entries
    puts title+': '+entries.to_s
  }
end

#main function
def main
  input = read_input 'dictionary.txt'
  output = {'carr' => 'carrots', 'give' => 'give'} #TODO replace with real string parsing
  write_output 'sequences', output.keys
  write_output 'words', output.values
end

main








