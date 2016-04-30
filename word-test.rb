#A program which, given a dictionary, generates two output files, 'sequences' and 'words'. 'sequences' contains every sequence of four letters that appears in exactly one word of the dictionary, one sequence per line. 'words' contains the corresponding words that contain the sequences, in the same order, again one per line.

class WordTester
  require 'open-uri'

  #returns an array containing lines from a text file
  def self.read_file(  textfile  )
    input = []
    
    open(textfile, "r") do |f|
      f.each_line do |line|
        input << line.delete("\n")
      end
    end
  
    return input
  end

  #writes an array to a text file
  def self.write_file(  title, entries  )
    open(title, 'w') { |f|
      f.puts entries
    }
  end

  #find unique 4 letter sequences
  def self.analyze(  lines  )
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
end

#main function
def main
  lines = WordTester.read_file 'https://s3.amazonaws.com/cyanna-it/misc/dictionary.txt'
  output = WordTester.analyze lines
  WordTester.write_file 'sequences.txt', output.keys
  WordTester.write_file 'words.txt', output.values
end

main

#Some basic testing
require "test/unit"
class TestProgram < Test::Unit::TestCase
  
  #does read work as expected?
  def test_read_file
    lines = WordTester.read_file 'Dictionary.txt'
    assert_equal(lines[0], "arrows")
    assert_equal(lines[1], "carrots")
    assert_equal(lines[2], "give")
    assert_equal(lines[3], "me")    
  end
  
  #does write create a file?
  def test_write_file
    lines = ['a','b','c','d']
    WordTester.write_file 'writetestfile.txt', lines
    assert(File.exists?('writetestfile.txt'))
    
    File.delete('writetestfile.txt')
  end
  
  #does read+write work as expected?
  def test_read_write_file
    lines = ['a','b','c','d']
    WordTester.write_file 'readwritetestfile.txt', lines
    
    lines = WordTester.read_file 'readwritetestfile.txt'
    assert_equal(lines[0], "a")
    assert_equal(lines[1], "b")
    assert_equal(lines[2], "c")
    assert_equal(lines[3], "d")
    
    File.delete('readwritetestfile.txt')
  end
  
  #verify that the result successfully eliminated sequences that are duplicate.
  def test_analyze
    lines = WordTester.read_file 'Dictionary.txt'
    output = WordTester.analyze lines
    assert_equal(output.keys, output.keys.uniq)
  end
end