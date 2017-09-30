
$tokens = [
]

class Token
    def initialize(type)
        @type = type #sym
    end

    def inspect
    end
end

class Identifier < Token
    def initialize(name)
        super
        @name = name
    end

    def inspect
    end
end

class Number < Token
    def initialize
    end
end

class Operator < Token
    def initialize
    end
end

class BinaryOperator
end
