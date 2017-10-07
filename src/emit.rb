require_relative 'parser'

class Emitter

    def initialize(ast)
        @ast = ast
    end

    def emit_function(definition)
        f_out = ''
    end

    def run
        p @ast
    end
end

toks = Lexer.new("extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()

