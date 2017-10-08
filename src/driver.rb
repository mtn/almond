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
end").lex()
                 # extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
p toks
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()



        # if x > 2 then
        #     1
        # else
        #     2
