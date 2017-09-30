
class ExprAST
end

class NumberExprAST < ExprAST
    def initialize(val)
        @val = val
    end
end

class VariableExprAST < ExprAST
    def initialize(name)
        @name = name
    end
end

class BinaryExprAST < ExprAST
    def initialize(op,lhs,rhs)
        @op = op
        @lhs = lhs
        @rhs = rhs
    end
end

class CallExprAST < ExprAST
    def initialize(callee,args)
        @callee = callee
        @args = args
    end
end

class PrototypeAST < ExprAST
    attr_reader :name

    def initialize(name,args)
        @name = name
        @args = args
    end
end

class FunctionAST < ExprAST
    def initialize(proto,body)
        @proto = proto
        @body = body
    end
end

