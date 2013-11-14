require_relative "wordset"

FILE = "sources/kjvtxt_clean/gospels.txt"


class Markov

  def initialize
    @wordset = WordSet.new
    @depth = 2
  end


  def read_file(filename)
    text = File.read(filename)
    @wordset.import_text_two text
  end


  def generate
    words = @wordset.random_words  #["The", "book"]
    word = "of"  # @wordset.random_word
    words << word
    puts words

    25.times do
      new_word = @wordset.get_next_word(words.slice(-@depth, @depth))
      words << new_word
      word = new_word
    end

    puts words.join(" ")
  end
end

if ARGV.length == 0
  puts "Usage markov sourcefiles"
  exit
end

markov = Markov.new
ARGV.each do |arg| 
  puts arg
  markov.read_file arg 
end

markov.generate






