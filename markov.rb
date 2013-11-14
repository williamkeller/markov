require_relative "wordset"

FILE = "sources/kjvtxt_clean/gospels.txt"


class Markov

  def initialize(depth)
    @wordset = WordSet.new
    @depth = depth
  end


  def read_file(filename)
    text = File.read(filename)
    @wordset.import_text(text, @depth)
  end


  def generate
    words = @wordset.random_words 
    word = ""

    150.times do
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

markov = Markov.new(3)
ARGV.each do |arg| 
  markov.read_file arg 
end

markov.generate






