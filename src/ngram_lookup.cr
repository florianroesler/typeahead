require "cadmium"
require "string_pool"
require "./completion_strategy"

class NgramLookup < CompletionStrategy
  NGRAM_MIN_DEFAULT = 2
  NGRAM_MAX_DEFAULT = 5

  def initialize
    @lookup = Hash(String, Set(String)).new { |hash, key| hash[key] = Set(String).new }
  end

  def push(sentence : String)
    process_sentence(sentence).each do |ngrams|
      ngrams.each { |ngram| @lookup[ngram].add(sentence) }
    end
  end

  def complete(query : String, count = 10)
    query = query.downcase
    results = Set(String).new
    quick_peak = @lookup.fetch(query, Set(String).new)
    results = results.concat(quick_peak)

    if results.size >= count
      return results.to_a[0..count - 1]
    end

    ngrams = process_sentence(query)
    sorted_ngrams = ngrams.sort_by { |n| n.size }.reverse

    sorted_ngrams.each do |ngram|
      results = results.concat(@lookup.fetch(ngram, Set(String).new))
      if results.size >= count
        return results.to_a[0..count - 1]
      end
    end

    results.to_a[0..count - 1]
  end

  private def generate_ngrams(word : String, min = NGRAM_MIN_DEFAULT, max = NGRAM_MAX_DEFAULT)
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
