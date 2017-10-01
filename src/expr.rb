
class Prototype
    attr_reader :name

    def initialize(name,params)
        @name = name #str
        @params = params #[str]
    end

    def inspect
        "Prototype(#{@name.inspect},#{@params.inspect})"
    end
end

class Definition
    attr_reader :proto

    def initialize(prototype,expr)
        @proto = prototype #prototype
        @expr = expr #expr
    end

    def inspect
        "Definition(proto: #{@proto.inspect} expr: #{@expr.inspect})"
    end
end

class Expr; end

class Number < Expr
    def initialize(val)
        @val = val
    end

    def inspect
        "expr.num(#{@val.inspect})"
    end
end

class Variable < Expr
    def initialize(name)
        @name = name
    end

    def inspect
        "expr.var(#{@name.inspect})"
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
        "expr.call(#{@name.inspect},#{@exprs.inspect})"
    end
end

class IfElse < Expr
    def initialize(cond,texpr,fexpr)
        @cond = cond
        @texpr = texpr
        @fexpr = fexpr
    end

    def inspect
        "expr.ifelse(#{@cond.inspect},#{@texpr.inspect},#{@fexpr.inspect})"
    end
end

