require "benchmark"
require "./trie.cr"

lines = File.read_lines("#{Dir.current}/data/words_alpha.txt")
trie = Trie.new

Benchmark.bm do |bm|
  bm.report("Init:") do
    lines.each do |word|
      trie.push(word.strip)
    end
  end

  bm.report("Count:") do
    trie.count
  end

  bm.report("Completion:") do
    trie.complete("aa")
  end
end
