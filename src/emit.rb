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

        @out.push(emit_expression(definition.expr))

        @out.push('}')
    end

    def emit_expression(expr)
        case expr
        when Number then
            expr.val.to_s
        when Call then
            expr.name + '(' + \
                expr.exprs.map! { |x| emit_expression(x) }.join(',') + \
            ')'
        when IfElse then
            'if (' + emit_expression(expr.cond) + ') {' + \
                'return (' + emit_expression(expr.texpr) + ')'+ \
            '} ' + \
            'else {' + \
                'return (' + emit_expression(expr.fexpr) + ')'+ \
            '} '
        when Binary then
            emit_expression(expr.lexpr) + $binaryTokTable[expr.op] + emit_expression(expr.rexpr)
        when Variable then
            expr.name
        end
    end

    def run
        p @ast
        puts ''
        p @ast.definitions[0].expr.class
        # p emit_expression(@ast.definitions[0].expr.rexpr.lexpr)
        # p emit_expression(@ast.definitions[0].expr.rexpr.rexpr.lexpr)
        puts ''
        for d in @ast.definitions
            emit_function(d)
        end
        p @out
    end
end

