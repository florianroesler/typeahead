require "kemal"
require "http/client"
require "logger"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

get "/" do
	"I am alive. How are you?"
end

get "/find" do |env|

end

Kemal.run
