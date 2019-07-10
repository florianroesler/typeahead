require "kemal"
require "http/client"
require "logger"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

require "./trie.cr"

lines = File.read_lines("#{Dir.current}/data/words_alpha.txt")
trie = Trie.new

lines.each do |word|
	trie.push(word.strip)
end

before_all do |env|
	env.response.content_type = "application/json"
end

get "/" do
	{ status: "OK" }.to_json
end

get "/complete" do |env|
	trie.complete(env.params.query.fetch("q", "")).to_json
end

Kemal.run
