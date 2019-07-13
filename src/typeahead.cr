require "./completion_strategy"
require "./trie"
require "./ngram_lookup"

class Typeahead < CompletionStrategy
  DEFAULT_COUNT = 10
  @strategies = [Trie.new, NgramLookup.new] of CompletionStrategy

  def push(sentence : String)
    stripped = sentence.strip
    @strategies.each { |s| s.push(stripped) }
  end

  def complete(query : String, count = DEFAULT_COUNT)
    result = Array(String).new

    @strategies.each do |strategy|
      next if result.size >= count
      puts strategy.complete(query).inspect
      result += strategy.complete(query)
    end

    result.uniq[0..count - 1]
  end
end
