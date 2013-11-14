require_relative "wordset"

FILE = "sources/kjvtxt_clean/gospels.txt"


class Markov

  def initialize
    @wordset = WordSet.new
  end


  def read_file(filename)
    text = File.read(filename)
    @wordset.import_text text
  end


  def generate
    words = []
    word = @wordset.random_word
    words << word

    500.times do

      new_word = @wordset.get_next_word(word)
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






