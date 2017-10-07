
$singleTokTable = {
    ',': lambda { Token.new(:comma) },
    '(': lambda { Token.new(:left_paren) },
    ')': lambda { Token.new(:right_paren) },
    ';': lambda { Token.new(:semicolon) },
    '+': lambda { OperatorTok.new(:plus) },
    '-': lambda { OperatorTok.new(:minus) },
    '*': lambda { OperatorTok.new(:times) },
    '/': lambda { OperatorTok.new(:divide) },
    '%': lambda { OperatorTok.new(:mod) },
    '=': lambda { OperatorTok.new(:equals) },
}

$comparisonTokTable = {
    '>':  lambda { OperatorTok.new(:greater_than) },
    '<':  lambda { OperatorTok.new(:less_than) },
    '>=': lambda { OperatorTok.new(:greater_than_equal) },
    '<=': lambda { OperatorTok.new(:less_than_equal) },
    '==': lambda { OperatorTok.new(:is_equal) },
}


class Token
    attr_reader :type

    def initialize(type)
        @type = type #sym
    end

    def ==(other)
        return false unless other.is_a? Token
        @type == other.type
    end

    def inspect
        "tok.#{@type.to_s}"
    end
end

class IdentifierTok < Token
    attr_reader :name

    def initialize(name)
        super(:identifier)
        @name = name
    end

    def ==(other)
        return false unless other.is_a? IdentifierTok
        @name == other.name
    end

    def inspect
        "tok.id.#{@name}"
    end
end

class NumberTok < Token
    attr_reader :val

    def initialize(val)
        super(:number)
        @val = val
    end

    def ==(other)
        return false unless other.is_a? NumberTok
        @val == other.val
    end

    def inspect
        "tok.num.#{@val}"
    end
end

class OperatorTok < Token
    attr_reader :op

    def initialize(op)
        super(:operator)
        @op = op #sym
    end

    def ==(other)
        return false unless other.is_a? OperatorTok
        @op == other.op
    end

    def inspect
        "tok.operator.#{@op}"
    end
end

