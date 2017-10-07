require_relative 'emit'

toks = Lexer.new("
#blah commend
def fib(x)
    if x == 3 then
        1
    else
        fib(x-1) + fib(x - 2)

fib(40)").lex()
                 # extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
p toks
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()

