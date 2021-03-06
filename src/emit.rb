require_relative 'parser'
require_relative 'errors'

class Emitter

    def initialize(ast)
        @ast = ast
        @out = ['#include <stdlib.h>',
                '#include <stdio.h>',
                '#include <math.h>',
               ]
    end

    def emit_function(definition)
        declaration = "double #{definition.proto.name}("
        for arg in definition.proto.params
            declaration += "double #{arg}"
        end
        declaration += '){'
        @out.push(declaration)

        if definition.expr.is_a? IfElse
            @out.push(emit_expression(definition.expr))
        else
            @out.push('return ' + emit_expression(definition.expr) + ';')
        end

        @out.push('}')
    end

    def emit_expression(expr)
        case expr
        when Number then
            expr.val.to_s
        when Call then
            raise UnknownFunction, "Unknown function #{expr.name}" \
                unless @ast.prototypes[expr.name]
            raise ArityMismatch, "Given #{expr.exprs.length.to_s} " + \
                            "Expected #{@ast.prototypes[expr.name].params.length.to_s}" \
                unless @ast.prototypes[expr.name].params.length == expr.exprs.length
            expr.name + '(' + \
                expr.exprs.map! { |x| emit_expression(x) }.join(',') + \
            ')'
        when IfElse then
            ifthen = 'if (' + emit_expression(expr.cond) + ') {'

            if expr.texpr.is_a? IfElse
                ifthen += emit_expression(expr.texpr)
            else
                ifthen += 'return (' + emit_expression(expr.texpr) + ');'
            end
            ifthen += '} '

            ifthen += 'else {'
            if expr.fexpr.is_a? IfElse
                ifthen += emit_expression(expr.fexpr)
            else
                ifthen += 'return (' + emit_expression(expr.fexpr) + ');'
            end
            ifthen += '}'

            ifthen
        when Binary then
            emit_expression(expr.lexpr) + $binaryTokTable[expr.op] + emit_expression(expr.rexpr)
        when Variable then
            expr.name
        end
    end

    def run
        for d in @ast.definitions
            emit_function(d)
        end

        @out.push('int main(){')
        for e in @ast.expressions
            @out.push('printf("%f\n",' + emit_expression(e)+');')
        end
        @out.push('}')

        @out.join("\n")
    end
end

