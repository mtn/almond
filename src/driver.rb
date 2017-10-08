require_relative 'emit'

toks = Lexer.new("
def fib(x)
    if x > 3 then
        if x > 3 then
            1
        else
            2
        end
    else
        fib(x-1) + fib(x - 2)
    end
end

fib(40);").lex()
                 # extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()
puts out

