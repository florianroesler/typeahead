require "kemal"
require "http/client"
require "logger"
require "./typeahead.cr"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

typeahead = Typeahead.new

lines = File.read_lines("#{Dir.current}/data/small.txt")
puts "Building Index"
lines.each { |sentence| typeahead.push(sentence) }
puts "Index Built"

before_all do |env|
	env.response.content_type = "application/json"
end

get "/" do
	{ status: "OK" }.to_json
end

get "/complete" do |env|
	query = env.params.query.fetch("q", "").strip
	typeahead.complete(query).to_json
end

Kemal.run
