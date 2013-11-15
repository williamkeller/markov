require "trollop"
require_relative "wordset"

FILE = "sources/kjvtxt_clean/gospels.txt"


class Markov
  attr_accessor :depth, :length, :start

  def initialize
    @wordset = WordSet.new
    @depth = depth
  end


  def read_file(filename)
    print "Reading #{filename}..."
    text = File.read(filename)
    @wordset.import_text(text, @depth)
    print "done.\n\n\n"
  end

  
  def dump_stats
    @wordset.dump_stats  
  end


  def generate
    if @start.class == String
      words = @start.split
    elsif @start == :start
      words = @wordset.starting_words
    else
      words = @wordset.random_words 
    end

    print words.join(" ")
    print " "
    word = ""

    length.times do
      new_word = @wordset.get_next_word(words.slice(-@depth, @depth))
      words << new_word
      word = new_word
      print "#{word} "
    end

    puts "\n\n\n"
  end
end


opts = Trollop::options do
  opt :source, "Source file to parse (required)", :type => :string
  opt :depth, "Search depth", :default => 1, :type => :integer
  opt :length, "Length of phrase to generate", :default => 100, :type => :integer
  opt :phrase, "Phrase to start with (in quotes)", :type => :string
  opt :random, "Start with a random word choice", :default => true
  opt :beginning, "Start at the beginning of the source file", :default => false
  opt :times, "The number of times to generate text", :default => 1, :type => :integer
  opt :stats, "Display statistics about the word set, rather than generating text", :default => false
end

if opts[:source] == false
  puts "source file is required"
  exit
end

if opts[:phrase]
  if opts[:phrase].split.length < opts[:depth]
    puts "Starting phrase must be at least as long as the value of --depth"
    exit
  end
end

markov = Markov.new
markov.depth = opts[:depth]
markov.length = opts[:length]


if opts[:phrase]
  markov.start = opts[:phrase]
elsif opts[:beginning] == true
  markov.start = :start
else
  markov.start = :random
end
  

begin
  markov.read_file opts[:source]
rescue
  puts "Could not read #{opts[:source]}"
  exit
end

if opts[:stats]
  markov.dump_stats
else
  opts[:times].times do
    markov.generate
  end
end





