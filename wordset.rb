class WordSet
  attr_reader :weighted_value

  def initialize(depth = 2, words = nil)
    @depth = depth
    if words 
      @words = words 
      @weighted_value = @words.values.inject(0) { |sum, value| sum + value }
    else
      @words = Hash.new
      @weighted_value = 0
    end
  end


  def import_text(text, depth)
    words = text.split
    prev = Array.new
    depth.times { prev << words.shift }
    lastword = prev.join(" ")

    words.each do |word|

      pair = [lastword, word]
      if @words.has_key? pair
        @words[pair] += 1
      else
        @words[pair] = 1
      end

      prev.shift
      prev << word
      lastword = prev.join(" ")
    end

    @weighted_value = @words.values.inject(0) { |sum, value| sum + value }
  end

  def dump_stats
    puts "#{@words.keys.length} entries"
    words = @words.to_a.sort_by {|o| o[1] }.reverse
    words.slice(0, 1000).each do |word|
      puts "#{word[1]} : #{word[0]}"
    end
  end


  def phrase_count
    @words.keys.length
  end


  def find_subset(words)
    if words.class == Array
      words = words.join(" ")
    end

    newset = Hash.new
    @words.each_pair do |key, value|
      if key[0] == words
        newset[key] = value
      end
    end
    WordSet.new(@depth, newset)
  end


  def starting_words
    @words.keys[0][0].split
  end


  def random_words
    @words.keys[rand(@words.keys.length)][0].split
  end


  def weighted_pair_at(index)
    current = 0
    new_pair = nil
    @words.each_pair do | key, value|
      current += value
      if current >= index
        new_pair = key
        break
      end
    end

    new_pair
  end


  def get_next_word(words)
    subset = find_subset(words)
    index = rand(subset.weighted_value)
    pair = subset.weighted_pair_at(index)
    if(pair.nil?)
      puts "Error"
      puts words
      puts subset
      puts index
    end
    pair[1]
  end

  def to_s
    str = ""
    str += "@weighted_value: #{@weighted_value}\n"
    str += "@words: #{@words.inspect}"

  end


end