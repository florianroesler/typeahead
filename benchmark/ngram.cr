require "benchmark"
require "../src/ngram_lookup.cr"

ngram_lookup = NgramLookup.new

# lines = File.read_lines("#{Dir.current}/data/words_alpha.txt")
# ngram_lookup = NgramLookup.new
#
# Benchmark.bm do |bm|
#   bm.report("Init:") do
#     lines.each do |word|
#       ngram_lookup.push(word.strip)
#     end
#   end
# end


# Benchmark.ips do |bm|
#   bm.report("Push:") do
#     ngram_lookup.push("Diaphremic Calystenics")
#   end
# end

ngram_lookup.push("Blabla Car")
ngram_lookup.push("Coca Cola")
ngram_lookup.push("Hermes")
ngram_lookup.push("Best Western")
ngram_lookup.push("Best Westeros Inc")
ngram_lookup.push("Allwest State")

puts ngram_lookup.complete("wes")
