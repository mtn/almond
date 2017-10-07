
class Environment
    attr_reader :externs
    attr_reader :definitions
    attr_reader :expressions
    attr_reader :prototypes

    def initialize
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
