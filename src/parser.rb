require_relative 'errors'
require_relative 'lexer'
require_relative 'expr'
require_relative 'file'

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
        when Token.new(:left_paren) then
            advance
            expr = parseExpression()
            parse(Token.new(:right_paren))
        when NumberTok then
            expr = @tokens[@ind]
            advance
        when IdentifierTok then
            name = @tokens[@ind].name
            advance
            if @tokens[@ind] == Token.new(:left_paren)
                params = parseTermList(parseExpression)
                expr = Call.new(name,params)
            else
                expr = Variable.new(name)
            end
        when Token.new(:if) then
            advance

            cond = parseExpr()
            parse(Token.new(:then))
            tVal = parseExpr()
            parse(Token.new(:else))
            fVal = parseExpr()

            expr = IfElse.new(cond,tVal,fVal)
        else
            raise UnexpectedToken
        end

        if @tokens[@ind].is_a? OperatorTok
            op = @tokens[@ind].op
            advance
            rhs = parseExpr()
            expr = Binary.new(expr,op,rhs)
        end

        expr
    end

    def parseDefinition
        parse(Token.new(:def))

        proto = parsePrototype()
        expr = parseExpression();
        definition = Definition.new(proto,expr)

        parse(Token.new(:semicolon))
        definition
    end

    def parseExtern
        parse(Token.new(:extern))
        proto = parsePrototype()
        parse(Token.new:semicolon)
        proto
    end

    def run
        file = Environment.new

    end
end

