require_relative 'tokens'

class Lexer

    def initialize(input)
        @input = input
        @ind = 0
    end

    def peek
        @input[@ind]
    end

    def advance
        @ind += 1
    end

    def readIdOrNum
        tok = ''

        loop do
            c = @input[@ind]
            break if not c or not isalphanum(c) and not c == '.'
            tok += c
            advance
        end

        tok
    end

    def getTok
        if not @input[@ind]
            return nil
        end

        while @input[@ind] and isspace(@input[@ind])
            advance
        end

        if @ind == @input.length
            return nil
        end

        if @input[@ind] == '#'
            advance
            loop do
                advance
                break if @input[@ind] == "\n"
                break if not @input[@ind]
            end
            return :comment
        end

        compLookup = $comparisonTokTable[@input[@ind].to_sym] \
            or $comparisonTokTable[@input[@ind..@ind+1].to_sym]
        if compLookup
            tok = compLookup.call()
            advance
            advance if [OperatorTok.new(:less_than_equal),
                OperatorTok.new(:greater_than_equal),
                OperatorTok.new(:is_equal)] .include? tok
            return tok
        end

        if $singleTokTable[@input[@ind].to_sym]
            tok = $singleTokTable[@input[@ind].to_sym].call()
            advance
            return tok
        end

        if isalphanum(@input[@ind])
            str = readIdOrNum()
            if str
                if ['def','extern','if','then','else','end'].include? str
                    return Token.new(str.to_sym)
                elsif isfloat(str)
                    return NumberTok.new(str.to_f)
                else
                    return IdentifierTok.new(str)
                end
            end
        end

        nil
    end

    def lex
        toks = []

        loop do
            tok = getTok()
            if tok
                if not tok == :comment
                    toks.push(tok)
                end
            else
                break
            end
        end

        toks
    end
end

def isspace(c)
    c.match(/^\s*$/)
end

def isalpha(c)
    c.match(/^[[:alpha:]]$/)
end

def isalphanum(c)
    c.match(/\A[[:alnum:]]+\z/)
end

def isdigits(c)
    c.match(/[0-9]+$/)
end

def isfloat(c)
    c.match(/^[-+]?([0-9]+(\.[0-9]+)?|\.[0-9]+)$/)
end

