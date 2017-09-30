
$singleTokTable = {
    ",": lambda { Token.new(:comma) },
    "(": lambda { Token.new(:left_paren) },
    ")": lambda { Token.new(:right_paren) },
    ";": lambda { Token.new(:semicolon) },
    "+": lambda { Operator.new(:plus) },
    "-": lambda { Operator.new(:minus) },
    "*": lambda { Operator.new(:times) },
    "/": lambda { Operator.new(:divide) },
    "%": lambda { Operator.new(:mod) },
    "=": lambda { Operator.new(:equals) }
}


class Token
    def initialize(type)
        @type = type #sym
    end

    def inspect
        "tok.#{@type.to_s}"
    end
end

class Identifier < Token
    def initialize(name)
        super(:identifier)
        @name = name
    end

    def inspect
        "tok.id.#{@name}"
    end
end

class Number < Token
    def initialize(val)
        super(:number)
        @val = val
    end
end

class Operator < Token
    def initialize(op)
        super(:operator)
        @op = op #sym
    end
end

