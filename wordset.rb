class WordSet
  attr_reader :weighted_value

  def initialize(words = nil)
    if words 
      @words = words 
      @weighted_value = @words.values.inject(0) { |sum, value| sum + value }
    else
      @words = Hash.new
      @weighted_value = 0
    end
  end

  def import_text(text)
    words = text.split
    lastword = ""

    words.each do |word|
      pair = [lastword, word]
      if @words.has_key? pair
        @words[pair] += 1
      else
        @words[pair] = 1
      end
      lastword = word
    end

    @weighted_value = @words.values.inject(0) { |sum, value| sum + value }
  end


  def find_subset(word)
    newset = Hash.new
    @words.each_pair do |key, value|
      if key[0] == word
        newset[key] = value
      end
    end
    WordSet.new(newset)
  end


  def random_word
#    @words.keys[rand(@words.keys.length)][rand(1)]
    @words.keys[0][1]
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


  def get_next_word(word)
    subset = find_subset(word)
    index = rand(subset.weighted_value)
    pair = subset.weighted_pair_at(index)
    pair[1]
  end


end