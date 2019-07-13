require "cadmium"
require "string_pool"

class NgramLookup
  def initialize
    @lookup = Hash(String, Set(String)).new { |hash, key| hash[key] = Set(String).new }
  end

  def push(sentence : String)
    process_sentence(sentence).each do |ngrams|
      ngrams.each do |ngram|
        @lookup[ngram].add(sentence)
      end
    end
  end

  def complete(query : String, count = 10)
    query = query.downcase
    @lookup.fetch(query, Set(String).new).to_a[0..count - 1]
  end

  private def generate_ngrams(word : String, min = 2, max = 10)
    collection = Array(String).new

    (0..word.size).each do |index|
      (min..max).each do |length|
        length = length - 1
        next if index + length >= word.size
        collection.push(word[index..(index+length)])
      end
    end

    collection
  end

  private def process_sentence(sentence : String)
    sentence = sentence.downcase
    tokenizer = Cadmium.case_tokenizer.new
    words = tokenizer.tokenize(sentence)

    words.map { |word| generate_ngrams(word) }
  end
end
