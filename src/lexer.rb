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
            break if not isalphanum(c) or c == '.'
            tok += c
            advance
        end

        tok
    end

    def getTok
        if not @input[@ind]
            return nil
        end

        while isspace(@input[@ind])
            advance
        end

        if @ind == @input.length
            return nil
        end

        if $singleTokTable[@input[@ind].to_sym]
            tok = $singleTokTable[@input[@ind].to_sym].call()
            advance
            return tok
        end

        if isalphanum(@input[@ind])
            str = readIdOrNum()
            if str
                if ['def','extern','if','then','else'].include? str
                    return Token.new(str.to_sym)
                elsif isdigits(str)
                    return Number.new(str.to_i)
                else
                    return Identifier.new(str)
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
                toks.push(tok)
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

toks = Lexer.new('def foo(n) (n * 100);').lex()
p toks
