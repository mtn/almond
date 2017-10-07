require_relative 'emit'

toks = Lexer.new("extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()

