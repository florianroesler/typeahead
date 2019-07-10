require "sentry"

sentry = Sentry::ProcessRunner.new(
    display_name: "Crystal Trie Server",
    build_command: "crystal build ./src/server.cr",
    run_command: "./server",
    files: ["./src/*.cr"]
)

sentry.run
