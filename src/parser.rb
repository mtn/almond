require_relative 'lexer'
require_relative 'expr'

class Parser
    def initialize(tokens)
        @tokens = tokens
        @ind = 0
    end

    def advance
        @ind += 1
    end

    def parse(token)
        raise 'Unexpected EOF' if not @tokens[@ind]
        raise "Unexpected token #{token}" if not token == @tokens[@ind]

        advance
    end

    def parseIdentifier
        raise 'Unexpected EOF' if not @tokens[@ind]

        case @tokens[@ind]
        when Identifier
            name = @tokens[@ind].name
            advance
            return name
        else
            raise "Unexpected token #{@tokens[@ind]}"
        end


    end
end

