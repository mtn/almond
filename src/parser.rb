require_relative 'errors'
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
        raise UnexpectedEOF if not @tokens[@ind]
        raise UnexpectedToken if not token == @tokens[@ind]

        advance
    end

    def parseIdentifier
        raise UnexpectedEOF if not @tokens[@ind]

        case @tokens[@ind]
        when Identifier
            name = @tokens[@ind].name
            advance
            return name
        else
            raise UnexpectedToken
        end
    end

    def parseTermList(parseFn)
        parse(Token.new(:left_paren))

        vals = []
        loop do
            break if @tokens[@ind] == Token.new(:right_paren)
            val = parseFn()
            if @tokens[@ind] == Token.new(:comma)
                parse(Token.new(:comma))
            end
            vals.push(val)
        end

        parse(Token.new(:right_paren))
        vals
    end

    def parsePrototype
        name = parseIdentifier()
        params = parseTermList(parseIdentifier)
        Prototype.new(name,params)
    end

    def parseExpression
        raise UnexpectedEOF if not @tokens[@ind]

        case @tokens[@ind]
        when Token.new(:left_paren)
            advance
            expr = parseExpression()
            parse(Token.new(:right_paren))
        when NumberTok
            expr = @tokens[@ind]
            advance
        when IdentifierTok
            value = @tokens[@ind].name
            advance
            # if @tokens[@ind] == 
        end

        expr
    end
end

a = IdentifierTok.new("abc")
b = Token.new(:paren)
puts a == b
