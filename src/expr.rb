
class Prototype
    attr_reader :name

    def initialize(name,params)
        @name = name #str
        @params = params #[str]
    end

    def inspect
        "Prototype(#{@name},#{@params})"
    end
end

class Definition
    attr_reader :proto

    def initialize(prototype,expr)
        @proto = prototype #prototype
        @expr = expr #expr
    end
end

class Expr; end

class Number < Expr
    def initialize(val)
        @val = val
    end

    def inspect
        "expr.num(#{@val})"
    end
end

class Variable < Expr
    def initialize(name)
        @name = name
    end

    def inspect
        "expr.var(#{@name})"
    end
end

class Binary < Expr
    def initialize(lexpr,op,rexpr)
        @op = op
        @lexpr = lexpr
        @rexpr = rexpr
    end

    def inspect
        "expr.binary(#{@lexpr.inspect},#{@op.inspect},#{@rexpr.inspect})"
    end
end

class Call < Expr
    def initialize(name,exprs)
        @name = name
        @exprs = exprs
    end

    def inspect
        "expr.call(#{@name},#{@exprs})"
    end
end

class IfElse < Expr
    def initialize(cond,texpr,fexpr)
        @cond = cond
        @texpr = texpr
        @fexpr = fexpr
    end

    def inspect
        "expr.ifelse(#{@cond},#{@texpr},#{@fexpr})"
    end
end

