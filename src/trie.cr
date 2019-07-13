class Trie
  property ending
  getter tries

  def initialize
    @ending = false
    @tries = Hash(Char, Trie).new { |hash, key| hash[key] = Trie.new }
  end

  def push(word : String)
    return if word.blank?
    character = word.char_at(0)
    chopped = word.lchop

    @tries[character].ending = true if chopped.blank?
    @tries[character].push(chopped)
  end

  def count
    @tries.sum do |_, trie|
      (trie.ending ? 1 : 0) + trie.count
    end || 0
  end

  def print_words(prefix : String)
    @tries.each do |char, trie|
      word = prefix + char
      trie.print_words(word)
      puts word if trie.ending
    end
  end

  def complete(word : String)
    word = word.strip.downcase
    start_node = seek(word)
    if start_node.nil?
      Array(String).new
    else
      start_node.collect_words(word)
    end
  end

  protected def collect_words(prefix : String, count = 10)
    values = Array(String).new
    @tries.each do |char, trie|
      word = prefix + char

      values.push(word) if trie.ending
      values.concat(trie.collect_words(word))

      return values if values.size >= count
    end

    values
  end

  protected def seek(word : String)
    return self if word.blank?

    character = word.char_at(0)
    return unless tries.has_key?(character)

    word = word.lchop
    tries[character].seek(word)
  end
end
