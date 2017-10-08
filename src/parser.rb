require_relative 'errors'
require_relative 'lexer'
require_relative 'expr'
require_relative 'env'

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
        raise UnexpectedToken, "Expected: #{token.inspect} Got: #{@tokens[@ind].inspect}" \
            unless token == @tokens[@ind]

        advance
    end

    def parseIdentifier
        raise UnexpectedEOF if not @tokens[@ind]

        case @tokens[@ind]
        when IdentifierTok
            name = @tokens[@ind].name
            advance
            return name
        else
            raise UnexpectedToken, 'Expected Identifier'
        end
    end

    def parseTermList(parseFn)
        parse(Token.new(:left_paren))

        vals = []
        loop do
            break if @tokens[@ind] == Token.new(:right_paren)
            val = parseFn.call()
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
        params = parseTermList(method(:parseIdentifier))
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
            expr = Number.new(@tokens[@ind].val)
            advance
        when IdentifierTok then
            name = @tokens[@ind].name
            advance
            if @tokens[@ind] == Token.new(:left_paren)
                params = parseTermList(method(:parseExpression))
                expr = Call.new(name,params)
            else
                expr = Variable.new(name)
            end
        when Token.new(:if) then
            advance

            cond = parseExpression()
            parse(Token.new(:then))
            thenVal = parseExpression()
            parse(Token.new(:else))
            elseVal = parseExpression()

            parse(Token.new(:end))
            expr = IfElse.new(cond,thenVal,elseVal)
        else
            raise UnexpectedToken
        end

        if @tokens[@ind].is_a? OperatorTok
            op = @tokens[@ind].op
            advance
            advance if [:less_then_equal,:greater_than_equal,:is_equal].include? op
            rhs = parseExpression()
            expr = Binary.new(expr,op,rhs)
        end

        expr
    end

    def parseDefinition
        parse(Token.new(:def))

        proto = parsePrototype()
        expr = parseExpression();
        definition = Definition.new(proto,expr)

        parse(Token.new(:end))
        definition
    end

    def parseExtern
        parse(Token.new(:extern))
        proto = parsePrototype()
        parse(Token.new(:semicolon))
        proto
    end

    def parseTopLevel
        env = Environment.new

        loop do
            break unless @tokens[@ind]

            case @tokens[@ind]
            when Token.new(:extern) then
                env.addExtern(parseExtern())
            when Token.new(:def) then
                env.addDefinition(parseDefinition())
            else
                expr = parseExpression()
                parse(Token.new(:semicolon))
                env.addExpression(expr)
            end
        end

        env
    end
end

