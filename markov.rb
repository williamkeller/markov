FILE = "sources/kjvtxt_clean/gospels.txt"

def read_file
  wordpairs = Hash.new

  text = File.read(FILE)
  words = text.split

  lastword = ""

  words.each do |word|
    pair = [lastword, word]
    if wordpairs.has_key? pair
      wordpairs[pair] += 1
    else
      wordpairs[pair] = 1
    end
    lastword = word
  end

  wordpairs
end


# Return a set containing the pairs where the first word matches word
def find_match_set(wordpairs, word)
  newset = Hash.new
  wordpairs.each_pair do |key, value|
    if key[0] == word
      newset[key] = value
    end
  end
  newset
end


def main
  pairs = read_file
  sentence = ""

  pair = pairs.keys[rand(pairs.keys.length)]

  200.times do
    set = find_match_set pairs, pair[1]
    set_value = set.values.inject(0) { |sum, value| sum + value }

    new_index = rand(set_value)
    index = 0
    new_pair = nil
    set.each_pair do | key, value|
      index += value
      if index >= new_index
        new_pair = key
        break
      end
    end
#    puts "old #{pair.inspect}, new #{new_pair.inspect}"
    sentence += " #{pair[0]}"
    pair = new_pair
  end

  puts sentence
end



main