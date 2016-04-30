#A program which, given a dictionary, generates two output files, 'sequences' and 'words'. 'sequences' contains every sequence of four letters that appears in exactly one word of the dictionary, one sequence per line. 'words' contains the corresponding words that contain the sequences, in the same order, again one per line.
require 'open-uri'

#returns an array containing lines from a text file
def read_file(  textfile  )
  input = []
  
  open( textfile, "r" ) do |f|
    f.each_line do |line|
      input << line
    end
  end
  
  return input
end

#writes an array to a text file
def write_file(  title, entries  )
  open(title+'.txt', 'w') { |f|
    f.puts entries
  }
end

#find unique 4 letter sequences
def analyze(  lines  )
  unique_sequences = {}
  
  regex = /(?=(....))/ #all 4 character sequences
  
  #count the frequency of regex matches
  sequence_frequency= Hash.new(0)
  lines.each do |line|
    line.scan(regex).each do|sequence|
      sequence_frequency[sequence] +=1
    end
  end
  
  #return only the unique sequences
  lines.each do |line|
    line.scan(regex).each do|sequence|
      if sequence_frequency[sequence] == 1
        unique_sequences[sequence] = line
      end
    end
  end 
  
  return unique_sequences
end

#main function
def main
  lines = read_file 'https://s3.amazonaws.com/cyanna-it/misc/dictionary.txt'
  output = analyze lines
  write_file 'sequences', output.keys
  write_file 'words', output.values
end

main








