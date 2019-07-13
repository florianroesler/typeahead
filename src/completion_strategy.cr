abstract class CompletionStrategy
  abstract def push(word : String);
  abstract def complete(query : String, count = 10) : Array(String);
end
