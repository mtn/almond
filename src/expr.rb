
class ExprAST
end

class Prototype < ExprAST
    def initialize(name,params)
        @name = name #str
        @params = params #[str]
    end
end


