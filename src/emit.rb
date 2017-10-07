require_relative 'parser'

class Emitter

    def initialize(ast)
        @ast = ast
    end

    def emit_function(definition)
        # f_out = ''
        p definition
    end

    def run
        # p @ast.definitions
        for d in @ast.definitions
            emit_function(d)
        end
    end
end

