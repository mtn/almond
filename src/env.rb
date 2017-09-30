
class Environment
    attr_reader :prototypes

    def initiallize
        @externs = []
        @definitions = []
        @expressions = []
        @prototypes = {}
    end

    def addExpression(expr)
        @expressions.push(expr)
    end

    def addExtern(proto)
        @externs.push(proto)
        @prototypes[proto.name] = proto
    end

    def addDefinition(definition)
        @definitions.push(definition)
        @prototypes[definition.proto.name] = definition.proto
    end
end
